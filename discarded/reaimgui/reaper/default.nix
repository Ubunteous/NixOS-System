{ pkgs ? import <nixpkgs> { } }:

{
  reaimgui = pkgs.callPackage ./reaimgui.nix { };
}
