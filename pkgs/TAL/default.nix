{ pkgs ? import <nixpkgs> { } }:

{
  pha = pkgs.callPackage ./tal.nix {
    name = "TAL Pha";
    url = "https://tal-software.com/downloads/plugins/TAL-Pha_64_linux.zip";
    sha256 = "sha256-I6LxwoEQU9fqMa+idu4T55noyVLcm9wcexjv/ypMSh0=";
  };
}
