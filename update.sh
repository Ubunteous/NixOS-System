#!/usr/bin/env sh

scriptDir=$(eval echo ~$USER'/.nix.d')

# use #minimal as parameter if need a specific host
rebuildTest() { sudo nixos-rebuild test --flake ${scriptDir}/${1:-#nixos}; } 

rebuildSwitch() { sudo nixos-rebuild switch --flake ${scriptDir}/${1:-#nixos}; }

rebuildBuild() { sudo nixos-rebuild build --flake ${scriptDir}/${1:-#nixos}; }

# specify flake input or use nixpkgs-unstable as default
# nix flake lock --update-input nixpkgs --update-input nix
flakeUpdateUnstable() { cd $scriptDir; nix flake lock --update-input ${1:-nixpkgs-unstable}; }

flakeUpdate() { cd $scriptDir; nix flake update; }

help() { declare -F; }

"$@"
