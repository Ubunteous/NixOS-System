# This provides the packages required by u-he plugin dialogs
# Place this shell.nix in the correct directory and run:
# nix-shell --run reaper # or another daw of your choice

with import <nixpkgs> {};
mkShell {
  NIX_LD_LIBRARY_PATH = lib.makeLibraryPath [
    gtk3
    glib
  ];
  NIX_LD = lib.fileContents "${stdenv.cc}/nix-support/dynamic-linker";
}
