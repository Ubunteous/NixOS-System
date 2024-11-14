{ stdenv, pkgs, lib, name, url, sha256 }:

stdenv.mkDerivation {
  inherit name;

  src = pkgs.fetchzip { inherit url sha256; };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/lib/{clap,vst,vst3}

    cp lib$name.so $out/lib/vst
    cp -r $name.vst3 $out/lib/vst3
    cp $name.clap $out/lib/clap
  '';
}
