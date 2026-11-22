{
  stdenv,
  pkgs,
  #
  autoPatchelfHook,
  gtk3,
  libGL,
  alsa-lib,
  libsm,
  libice,
  libx11,
  libxext,
  libxrandr,
  libxcursor,
  libxinerama,
  libxi,
  libGLX,
}:

stdenv.mkDerivation {
  name = "aalto";

  src = pkgs.fetchzip {
    url = "https://nyc3.digitaloceanspaces.com/madronalabs/installers/aalto/Aalto-2.0.2-linux.tar.gz";
    sha256 = "sha256-U+xkOzhViUqT4byA2EMSeyWDsEyOTsMg5I7SeCKxJuU=";

    # single directory expected in build file when true
    # use false when dealing with a flat list
    stripRoot = true;
  };

  dontBuild = true;

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [
    gtk3
    libGL
    alsa-lib # libasound
    libsm
    libice
    libx11
    libxext
    libxrandr
    libxcursor
    libxinerama
    libxi
    libGLX
    # libOpenGL
    # stdenv.cc.cc.lib # libstdc++
  ];

  installPhase = ''
    mkdir -p $out/lib/{vst3,clap,extra}

    cp -r VST3/* $out/lib/vst3
    cp -r CLAP/* $out/lib/clap
    cp -r Patches $out/lib/extra
  '';
}
