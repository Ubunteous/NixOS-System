{
  stdenv,
  pkgs,
  name,
  url,
  sha256,
}:

stdenv.mkDerivation {
  inherit name;
  src = pkgs.fetchzip { inherit url sha256; };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/lib/vst3
    cp -r ./$name/ $out/lib/vst3
  '';
}
