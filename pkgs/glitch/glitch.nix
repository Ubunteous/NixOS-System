{ stdenv, pkgs }:

stdenv.mkDerivation {
  name = "glitch";

  src = pkgs.fetchzip {
    url = "https://illformed.com/downloads/Glitch_2_1_5_Linux_Free.zip";
    sha256 = "sha256-cspn5blWQAW4urCo2nE0XvB3shxttT0bqrkFmsgRQMw=";

    # single directory expected in build file when true
    # use false when dealing with a flat list
    stripRoot = false;
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/lib/{vst,vst3,extra}

    cp -r glitch2.vst2 $out/lib/vst
    cp -r glitch2.vst3 $out/lib/vst3
    cp -r Glitch2_Presets $out/lib/extra
    cp Glitch2_User_Guide.pdf $out/lib/extra
  '';
}
