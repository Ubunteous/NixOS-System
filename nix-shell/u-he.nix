# { config, pkgs, ... }: {

# See this for more details
# https://unix.stackexchange.com/questions/522822/different-methods-to-run-a-non-nixos-executable-on-nixos

##################
#   DIAGNOSTIC   #
##################

# Fix for u-he dialog relying on these libraries:
# > ldd dialog.64
# libgtk-3.so.0 => not found
# libgobject-2.0.so.0 => not found => corresponds to glib
# libglib-2.0.so.0 => not found => corresponds to glib

###############
#   OPTIONS   #
###############

# + steam-run: steam-run "$DIALOG" "$@" # this works but is a dirty fix
# + nix-ld =>

#####################
#   FIND LIB NAME   #
#####################

# nix-locate --top-level libstdc++.so.6 | grep gcc

####################
#   NIX-LD SETUP   #
####################

# Install nix-ld by adding this to your flake input
# nix-ld = {
#   url = "github:Mic92/nix-ld";
#   inputs.nixpkgs.follows = "nixpkgs"; # "nixpkgs-unstable";
# };

# This goes to the module section of the flake output
# ld will be fully available in NixOS 23.05
# nix-ld.nixosModules.nix-ld

#   # The module in this repository defines a new module under (programs.nix-ld.dev) instead of (programs.nix-ld) 
#   # to not collide with the nixpkgs version.
#   { programs.nix-ld.dev.enable = true; }

# Not used to enable nix ld => programs.nix-ld.enable = true;

# Sets up all the libraries to load (option available from 23.05)
#   programs.nix-ld.libraries = with pkgs; [
#     gtk3
#     glib
#   ];
# }

############
#   BASH   #
############

# The install script and dialog (in plugin folder) need a change:
# #! /bin/bash => #! /usr/bin/env bash

#################
#   SHELL.NIX   #
#################

# To test this shell independantly, run nix-shell ~/.nix.d/nix-shell/u-he.nix --run ./dialog
# Expected output: usage: /home/<USER>/.u-he/<PLUGIN>/dialog.64 <register|save-preset|message|menu|license|text-input|msgv2|folder-select|file-select>

# This provides the packages required by u-he plugin dialogs
# Place this shell.nix in the correct directory and run:
# nix-shell --run reaper # or another daw of your choice

# Also, don't forget that ACE, Bazille and maybe also Filterscape and Uhbik
# need a change in dialog: /bin/bash => /usr/bin/env bash

###############
# CREDENTIALS #
###############

# In case of error, can be manually placed in ~/.u-he/<PLUGIN>/Support/com.u-he.<PLUGIN>.user.txt

with import <nixpkgs> { };
mkShell {
  NIX_LD_LIBRARY_PATH = lib.makeLibraryPath [ gtk3 glib ];
  NIX_LD = lib.fileContents "${stdenv.cc}/nix-support/dynamic-linker";
}
