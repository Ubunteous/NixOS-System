{
  pkgs ? import <nixpkgs> { },
}:

{
  tx16wx = pkgs.callPackage ./tx16wx.nix { };
}
