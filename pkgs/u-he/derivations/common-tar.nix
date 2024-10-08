{ pkgs, autoPatchelfHook, stdenv, gtk3, xorg, name, url, sha256 }:

stdenv.mkDerivation {
  inherit name;
  src = pkgs.fetchurl { inherit url sha256; };

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [ gtk3 xorg.xcbutilkeysyms xorg.xcbutil ];

  installPhase = ''
    mkdir -p $out/lib
    cp -r . $out/lib
  '';
}
