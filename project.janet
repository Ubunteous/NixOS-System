# run jpm test to get dependencies. Add missing dir ~/.local/share/janet/ if necessary

(declare-project
 :name "it"
 :description "Nix command line utility"
 # :url "https://github.com/hlissner/dotfiles"
 # :repo "git+https://github.com/hlissner/dotfiles"
 :dependencies [{:url "https://github.com/ianthehenry/cmd.git"} # :tag "v1.1.0"
		# {:url "https://github.com/janet-lang/spork.git"} # utils (includes a formatter)
		{:url "https://github.com/andrewchambers/janet-sh.git"}]) # :tag "v0.0.1" > error

(declare-executable
 :name "it"
 :entry "bin/ni.janet"
 :install true)
