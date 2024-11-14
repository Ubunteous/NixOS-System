{ pkgs ? import <nixpkgs> { } }:

{
  graillon = pkgs.callPackage ./auburn-sounds.nix {
    name = "Graillon";
    url = "https://www.auburnsounds.com/downloads/Graillon-FREE-3.0.zip";
    sha256 = "sha256-0HqfIoy6nYiWQPZzawKlN4cH/L7eKcKEKsAXkBVkAgA=";
  };
}
