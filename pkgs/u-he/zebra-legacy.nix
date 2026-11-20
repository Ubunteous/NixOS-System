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
    mkdir -p $out/lib
    (cd ./*/01* && tar xvf *.tar.xz && cd ./Zebra2-* && cp -r . $out/lib)
    (cd ./*/02* && tar xvf *.tar.xz && cd ./ZebraHZ-* && cp -r . $out/lib)
  '';
}
