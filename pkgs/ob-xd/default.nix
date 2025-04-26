{ pkgs ? import <nixpkgs> { } }:

{
  ob-xd = pkgs.callPackage ./ob-xd.nix {
    name = "OB-Xd";
    url = "https://demo.discodsp.com/Obxd37Linux.zip";
    sha256 = "sha256-X3jt/ZlbWF1Opv2E1BonmWRJPH5yuMQdu36ms5xKJP8=";
  };
}
