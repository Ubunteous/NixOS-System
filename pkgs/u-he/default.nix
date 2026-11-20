{
  pkgs ? import <nixpkgs> { },
}:

{
  ace = pkgs.callPackage ./u-he.nix {
    name = "Ace";
    url = "https://dl.u-he.com/releases/ACE_143_16518_Linux.tar.xz";
    sha256 = "sha256-BJxPBuuSVeXxriZNHJgrZ+rsTnXpYp9OmCKm3ywo5bU=";
  };

}
