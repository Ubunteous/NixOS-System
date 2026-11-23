{ stdenv, pkgs }:

stdenv.mkDerivation {
  name = "loudmax";

  src = pkgs.fetchzip {
    url = "https://www.dropbox.com/scl/fi/s6aawowxty7gpj0crvjq3/LoudMax_v1_47_Linux_x86_LADSPA.tar.gz?rlkey=0lyxstuwvi8pwadlp2nouw4ns&st=0wsjtp1f&dl=1";
    sha256 = "sha256-Pxdq3h4SjNLlwhlW9laTv4U6QWI8XQUdsihsGwc1yi4=";

    stripRoot = false;
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/lib/ladspa
    cp {la_LoudMax.so,ladspa.h} $out/lib/ladspa
  '';
}
