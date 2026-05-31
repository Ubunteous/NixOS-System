{ pkgs, autoPatchelfHook, stdenv, gtk3, glib, name, url, sha256 }:

stdenv.mkDerivation {
  inherit name;

  src = pkgs.fetchzip {
    inherit url sha256;
    stripRoot = false;
  };

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [ gtk3 glib libxcb-util libxcb-keysyms ];

  installPhase = ''
    mkdir -p $out/lib
    (cd ./*/01* && tar xvf *.tar.xz)    
    (cd ./*/02* && tar xvf *.tar.xz)
    cp -r . $out/lib
  '';
}
