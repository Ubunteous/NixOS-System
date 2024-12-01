{ pkgs ? import <nixpkgs> { } }:

{
  dotnet-script = pkgs.callPackage ./dotnet-script.nix { };
}

