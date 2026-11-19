{
  pkgs ? import <nixpkgs> { },
}:

{
  limiter-6-demo = pkgs.callPackage ./tdr.nix {
    name = "TDR Limiter 6 GE";
    url = "https://www.tokyodawn.net/labs/Limiter6GE/2.0.1/TDR%20Limiter%206%20GE%20(demo).tar.gz";
    sha256 = "sha256-44xaZeqFMpuao//W7nlNMx+z+wpNrsaSw8XEZER7CSw=";
  };
}
