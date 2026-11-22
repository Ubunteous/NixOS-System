{
  pkgs ? import <nixpkgs> { },
}:

{
  aalto = pkgs.callPackage ./aalto.nix { };
}
