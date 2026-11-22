{
  pkgs ? import <nixpkgs> { },
}:

{
  apqualizr = pkgs.callPackage ./apqualizr.nix {
    name = "apQualizr2";
    url = "https://apulsoft.ch/apqualizr2/apqualizr2-linux-2-7-8.tar.xz";
    sha256 = "sha256-iEvMBZCkOXnrn9f4wY7zjOGAOGZ6okEbei8suvMBn7Q=";
  };
}
