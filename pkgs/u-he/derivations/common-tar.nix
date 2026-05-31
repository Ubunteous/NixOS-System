{ pkgs, autoPatchelfHook, stdenv, gtk3, name, url, sha256 }:

stdenv.mkDerivation {
  inherit name;
  src = pkgs.fetchurl { inherit url sha256; };

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [ gtk3 libxcb-keysyms libxcb-util ];

  installPhase = ''
    mkdir -p $out/lib
    cp -r . $out/lib
  '';
}
