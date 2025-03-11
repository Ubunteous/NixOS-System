{ pkgs, autoPatchelfHook, stdenv, name, url, sha256 }:

stdenv.mkDerivation {
  inherit name;

  src = pkgs.fetchzip {
    inherit url sha256;
    stripRoot = false;
  };

  nativeBuildInputs = [ autoPatchelfHook ];

  installPhase = ''
    mkdir -p $out/lib
    cp -r . $out/lib
  '';
}
