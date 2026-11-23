{
  pkgs ? import <nixpkgs> { },
}:

{
  loudmax = pkgs.callPackage ./loudmax.nix { };
}
