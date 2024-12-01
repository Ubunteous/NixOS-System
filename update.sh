#!/usr/bin/env sh

scriptDir=$(eval echo ~$USER'/.nix.d')

# use #minimal as parameter if need a specific host
test() { sudo nixos-rebuild test --flake ${scriptDir}/${1:-#nixos}; } 

switch() { sudo nixos-rebuild switch --flake ${scriptDir}/${1:-#nixos}; }

build() { sudo nixos-rebuild build --flake ${scriptDir}/${1:-#nixos}; }

# specify flake input or use nixpkgs-unstable as default
# nix flake lock --update-input nixpkgs --update-input nix
flakeUpdateUnstable() { cd $scriptDir; nix flake lock --update-input ${1:-nixpkgs-unstable}; }

flakeUpdate() { cd $scriptDir; nix flake update; }

clean() { sudo nix-collect-garbage -d; }

cleanSwitch() { clean && rebuildSwitch && reboot; }

delta() {
    # see recent additions from last nixos rebuild
    previous=$(ls -Art /nix/var/nix/profiles/ | tail -n 3 | head -n 1)
    
    nix store diff-closures /nix/var/nix/profiles/$previous /nix/var/nix/profiles/system | grep "+"
}

showGens() {
    echo -e "Systems currently in store:\n"
    ls /nix/var/nix/profiles/ | grep system-
}

help() { declare -F; }

"$@"
