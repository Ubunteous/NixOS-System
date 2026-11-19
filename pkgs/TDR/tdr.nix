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
    stripRoot = false;
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/lib/{vst,vst3}

    cp *.so $out/lib/vst
    cp -r *.vst3 $out/lib/vst3
  '';
}
