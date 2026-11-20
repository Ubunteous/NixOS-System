{
  stdenv,
  pkgs,
  name,
  url,
  sha256,
}:

stdenv.mkDerivation {
  inherit name;

  src = pkgs.fetchzip {
    inherit url sha256;

    # for some reason, the default header gets 403 (forbidden)
    # hence, we pose as a wget request to retrieve data anyway
    curlOptsList = [
      "-A"
      "Wget/1.21.4"
    ];

    stripRoot = false; # if the tarball has no single top-level directory
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/lib/{clap,vst,vst3}
    cp -r vst/* $out/lib/vst
    cp -r vst3/* $out/lib/vst3
  '';
}
