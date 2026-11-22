{
  pkgs,
  autoPatchelfHook,
  stdenv,
  gtk3,
  glib,
}:

stdenv.mkDerivation {
  name = "Zebra-Legacy";

  src = pkgs.fetchzip {
    url = "https://dl.u-he.com/releases/Zebra_Legacy_294_16765_Linux.zip";
    sha256 = "sha256-WfrDTmKj0fg4Y3Aayk4QaA6HJ6uQp7Uw04tA9HoOXGQ=";

    stripRoot = false;
  };

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [
    gtk3
    glib
    pkgs.libxcb-util
    pkgs.libxcb-keysyms
  ];

  installPhase = ''
    # mkdir -p "$out/lib/Zebra Legacy Soundsets"

    ##########
    # Zebra2 #
    ##########

    # (cd ./*/01* && tar xvf *.tar.xz && cd ./Zebra2-* && cp -r . $out/lib)

    (mkdir -p "$out/lib/Zebra2" &&
    cd ./*/01* &&
    tar xvf *.tar.xz &&
    cd ./Zebra2-* &&
    # cp -r . $out/lib
    cp "./Zebra2/Zebra2.64.so" "$out/lib/Zebra2/Zebra2.64.so" &&
    cp "./Zebra2/dialog" "$out/lib/Zebra2/dialog" &&
    cp "./Zebra2/dialog.64" "$out/lib/Zebra2/dialog.64")

    ###########
    # ZebraHZ #
    ###########

    # (cd ./*/02* && tar xvf *.tar.xz && cd ./ZebraHZ-* && cp -r . $out/lib)

    (mkdir -p "$out/lib/ZebraHZ" &&
    cd ./*/02* &&
    tar xvf *.tar.xz &&
    cd ./ZebraHZ-* &&
    # cp -r . $out/lib
    cp "./ZebraHZ/ZebraHZ.64.so" "$out/lib/ZebraHZ/ZebraHZ.64.so" &&
    cp "./ZebraHZ/dialog" "$out/lib/ZebraHZ/dialog" &&
    cp "./ZebraHZ/dialog.64" "$out/lib/ZebraHZ/dialog.64")

    #############
    # SOUNDSETS #
    #############

    # (cd ./*/03* && cp -r . "$out/lib/Zebra Legacy Soundsets")
  '';
}
