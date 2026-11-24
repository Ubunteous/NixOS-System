{
  pkgs ? import <nixpkgs> { },
}:

{
  pha = pkgs.callPackage ./tal.nix {
    name = "TAL Pha";
    url = "https://tal-software.com/downloads/plugins/TAL-Pha_64_linux.zip";
    sha256 = "sha256-44xaZeqFMpuao//W7nlNMx+z+wpNrsaSw8XEZER7CSw=";
  };
}
