#!/usr/bin/env janet

(import cmd)
(import sh)

# Get libraries with jpm deps in the dir with project.janet
# taken from hey which is itself inspired by Guix CLI
# I can improve my own commands later

# Taken from hlissner. I will eventually have the same options
# SYNOPSIS:
#   hey [-?|-??|-???|-!] [-h|--help] COMMAND [ARGS...]
#
# OPTIONS:
#   -!           -- Do a dry run. WARNING: It's up to called scripts to obey!
#   -?,-??,-???  -- Enable debug (verbose) mode.
#   -h,--help    -- Display the documentation embedded in a target script's
#                   header.
#
# COMMANDS:
#   - build|b    -- Build nix images or recompile bin/hey
#   - exec       -- Dispatch to $DOTFILES_HOME/{,hosts/$HOST,config/$WM}/bin/shim.d $PATH
#   - get|set    -- Alias for hey vars {get,set} ...
#   - gc         -- Run garbage collection on the user's/system's profile
#   - help|h     -- Display documentation for the command
#   - hook       -- Trigger scripts associated with an event
#   - host       -- Dispatch to $DOTFILES_HOME/hosts/$HOST/bin
#   - info       -- Display information about current system (JSON)
#   - path       -- Display path to area of my dotfiles
#   - profile    -- Manage or analyze a system or user nix profile
#   - pull       -- Update flake inputs
#   - reload     -- Run reload hooks
#   - repl       -- Open a Janet, Nix, or nix-develop REPL
#   - swap       -- Swap nix-store symlinks with copies (and back)
#   - sync|s     -- Rebuild this flake (using nixos-rebuild)
#   - test       -- Run Hey and/or Nix test suites
#   - which      -- Print out the script's path (with arguments) w/o executing it
#   - wm         -- Dispatch to $DOTFILES_HOME/config/$WM/bin
#   - vars       -- Get or set session or persistent state in userspace.
#   - @*         -- Dispatch to $DOTFILES_HOME/config/${1#@}/bin
#   - .*         -- Tries to be smart. Looks for any executable under host, wm,
#                   then $DOTFILES_HOME/bin.

(cmd/defn nixos-rebuild
	  "Command to rebuild NixOS with any method and host"
	  [type (optional ["type (test)" :string] "test")
	   host (optional ["host (nixos)" :string] "nixos")
	   [--reboot -r] (flag) "Reboot after rebuild switch"
	   [--shutdown -s] (flag) "Shutdown after rebuild switch"
	  ]
	  
	  (let [flake-path (string (os/getenv "HOME") "/.nix.d/")]
	    (case type
	      # janet does not seem to support clojure's list as case
	      "test"
	      (sh/$ sudo nixos-rebuild ,type --flake ,(string flake-path "#" host))

	      "debug"
	      (sh/$ sudo nixos-rebuild --show-trace test --flake ,(string flake-path "#" host))

	      "switch"
	      (do
		(sh/$ sudo nixos-rebuild ,type --flake ,(string flake-path "#" host))
		(when reboot (sh/$ reboot))
		(when shutdown (sh/$ shutdown now)))

	      "build"
	      (sh/$ nix run ,flake-path -- ,type --flake ,(string flake-path "#work"))

	      "min"
	      (sh/$ sudo nixos-rebuild test --flake ,(string flake-path "#minimal"))
	      
	      (print "Unknown: " type ". Try test, switch, min, debug or build with host main, server or minimal."))))


(cmd/defn flake
	  "Utilities related to nix flakes"
	  [command (required ["command (show, archive, update (with --input) or update-all)" :string])
	   [--input -i] (optional ["Flake input to manage (default: nixpkgs-unstable)" :string] "nixpkgs-unstable")
	  ]

	  (let [flake-path (string (os/getenv "HOME") "/.nix.d/")]
	    (case command
	      "show" (sh/$ nix flake show ,flake-path)
	      "archive" (sh/$ nix flake archive ,flake-path)

	      "update" (do (print "Updating only nixpkgs-unstable. Use update-all or provide an --input for more")
			   (sh/$ nix flake update ,input --flake ,flake-path))

	      "update-all" (do (print "full flake update")
			       (sh/$ nix flake update --flake ,flake-path))
	      
	      (print "Flake command " command " unknown. Try show, archive, update or update-all."))))


(cmd/defn nix
	  "Utilities related to nix itself"
	  [command (required [" command\n  => show, previous or clean-profiles/simple/full" :string])]

	  (case command
		  "show"
		  (do
			(sh/$ echo -e "\nSystems currently in store:")
			(sh/$ ls /nix/var/nix/profiles/ | grep system-))

		  "clean-profiles"
		  (sh/$ nix-store --gc --print-roots | egrep -v "^(/nix/var|/run/\\w+-system|\\{memory|/proc)")

		  "clean-simple"
		  (sh/$ sudo nix-collect-garbage)

		  "clean-full"
		  (sh/$ sudo nix-collect-garbage -d)

		  (print "Nix command " command " unknown. Try show, previous, qbit or clean-profiles/simple/full.")))


(cmd/defn borg
		  "Utilities for borg backups"
		  [command (required [" command\n  => server-chmod/verify/init or client-backup/list " :string])]

		  (let [bkp-name (apply string
								(array/concat
								 (map (os/date) [:month :year]) "-backup"))]
			(case command
			  "server-chmod"
			  (sh/$ sudo chmod 777 /var/lib/borgbackup) # risky
			  
			  "server-verify"
			  (do
				(sh/$ cat /etc/ssh/authorized_keys.d/borg)
				(sh/$ ls /var/lib/borgbackup))

			  "client-init"
			  (sh/$ borg init --encryption=none nix@server:/var/lib/borgbackup)

			  "client-backup"
			  (sh/$ borg create --stats nix@server:/var/lib/borgbackup::backup ~/org)

			  "client-list"
			  (sh/$ borg list "nix@server:/var/lib/borgbackup"))))


(cmd/defn set-impure
		  "Install impure configurations on the system"
		  [command (required [" command\n  => qbit" :string])]

		  (let [qbit-config (string (os/getenv "HOME") "/.nix.d/files/qBittorrent.conf")]
			(case command
			  "qbit"
			  (sh/$ sudo cp ,qbit-config "/var/lib/qbittorrent/qBittorrent/config/"))))


(cmd/defn sofle
		  "Compile and flash sofle with QMK"
		  [command (optional ["command (compile, flash, config, compile-flash or default)" :string])]
		  
		  (let [sofle-path "splitkb/aurora/sofle_v2/rev1"
				layout "colemak"]

			(case command
			  "compile"
			  (sh/$ qmk compile -kb ,sofle-path -km ,layout)

			  "flash"
			  (sh/$ qmk flash -kb ,sofle-path -km ,layout)

			  # needs sudo access
			  # "mount"
			  # (let [device (sh/$< lsblk -o "NAME,LABEL"|
			  # 			  grep RPI-RP2 |
			  # 			  awk "{print $1;}" |
			  # 			  tr -cd "[:alnum:]|\n")]

			  # 	(if-not (nil? device)
			  # 	  (sh/$ mount (string "/dev/" device) "/run/media/usb/")
			  # 	  (print "Device not found")))

			  "compile-flash"
			  (do
				(sh/$ qmk compile -kb ,sofle-path -km ,layout)
				(sh/$ qmk flash -kb ,sofle-path -km ,layout))

			  "config"
			  (do
				(sh/$ qmk config compile.keyboard=splitkb/aurora/sofle_v2/rev1 compile.keymap=colemak)
				(sh/$ qmk config flash.keyboard=splitkb/aurora/sofle_v2/rev1 flash.keymap=colemak))
			  
			  "default"
			  (sh/$ qmk compile -kb ,sofle-path -km "default")
			  
			  nil
			  (print "Choose either compile, flash compile-flash or default"))))


(cmd/main
 (cmd/group
  "Group of commands use to administrate my nix system."
  rebuild nixos-rebuild
  r nixos-rebuild

  sofle sofle
  kb sofle

  borg borg
  set-impure set-impure
  flake flake
  nix nix))
