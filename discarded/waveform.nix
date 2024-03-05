# run with:
# nix-build -A full-waveform waveform.nix
# try again later with: https://nixos.wiki/wiki/Packaging/Binaries

let nixpkgs = import <nixpkgs> {};
    stdenv = nixpkgs.stdenv;
in rec {
  partial-waveform = stdenv.mkDerivation {
    name = "partial-waveform";
    builder = ./builder.sh;
    dpkg = nixpkgs.dpkg;
    src = nixpkgs.fetchurl {
      url = "https://cdn.tracktion.com/file/tracktiondownload/w12/1218/waveform_64bit_v12.1.8.deb";
      sha256 = "sha256-GFes0ijdJyRcrsK927kpO2PLdC2sa0ru9EzDBdX5RYg";
    };
  };
  full-waveform = nixpkgs.buildFHSUserEnv {
    name = "full-waveform";
    targetPkgs = pkgs: [ partial-waveform ];
    multiPkgs = pkgs: [ pkgs.dpkg ];
    runScript = "waveform";
  };
}

  # builder.sh
  # source $stdenv/setup
  # PATH=$dpkg/bin:$PATH

  # dpkg -x $src unpacked

  # mv unpacked/usr/* unpacked/
  # rmdir unpacked/usr/


  # # bug with this line
  # cp -r unpacked/* $out/
