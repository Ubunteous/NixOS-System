default:
	just --list

[group('Build')]
build type="build" host="work":
	nix run . -- {{type}} --flake ./#{{host}}

[group('Build')]
rebuild type="test" host="nixos":
	sudo nixos-rebuild {{type}} --flake ./#{{host}}

[group('Build')]
rebuild-debug host="nixos":
	sudo nixos-rebuild --show-trace test --flake ./#{{host}}

[group('Build')]
nixmin:
	sudo nixos-rebuild test --flake ./#minimal


[group('Flake')]
flake-show:
	nix flake show

[group('Flake')]
flake-update $full="false":
	#!/usr/bin/env sh
	if [ ! $full = "true" ]; then
	    echo "unstable update (pass true for full)"
		nix flake lock --update-input nixpkgs-unstable
	else
	    echo "full flake update"
		nix flake update
	fi	

[group('Flake')]
archive:
	# retrieve missing flake inputs
	nix flake archive


[group('Clean')]
clean $full="false":
	#!/usr/bin/env sh
	if [ ! $full = "true" ]; then
	    echo "simple clean (full=false)"
	    sudo nix-collect-garbage
	else
	    echo "full clean (full=true)"
		sudo nix-collect-garbage -d
	fi

[group('Clean')]
clean-profiles:
	#!/usr/bin/env sh
	# nix-store --gc --print-roots | egrep -v "^(/nix/var|/run/\w+-system|\{memory|/proc)" | awk '{ print $1 }' | grep -vE 'home-manager|flake-registry\.json' | xargs -L1 unlink
	nix-store --gc --print-roots | egrep -v "^(/nix/var|/run/\w+-system|\{memory|/proc)"

# command missing
# clean-home:
# 	#!/usr/bin/env sh
# 	home-manager expire-generations "$(date)"


[group('Misc')]
delta: # broken
	#!/usr/bin/env sh
	if [ $(ls /nix/var/nix/profiles/ | wc -l) -eq 4 ]
	then
	    echo "Not enough systems to compare in /nix/var/nix/profiles"
		exit 0 # avoid just error with this exit code
	fi
	
	previous=$(ls -Art /nix/var/nix/profiles/ | tail -n 3 | head -n 1)
	nix store diff-closures /nix/var/nix/profiles/$previous /nix/var/nix/profiles/system | grep "+"

[group('Misc')]
show-gens:
    @echo -e "Systems currently in store:\n"
    @ls /nix/var/nix/profiles/ | grep system-

# nvim-clean:
# 	rm -r ~/.config/nvim/*


# nvim-test:
# 	(cd ~/.config/nvim/; \
# 	cp --preserve --remove-destination "$(readlink -f 'init.lua')" "init.lua"; \
# 	mkdir lua-c; \
# 	mv lua/plugins/* lua-c/; \
# 	rm lua; \
# 	mv lua-c lua; \
# 	chmod +Rrw "init.lua")
