{ pkgs, autoPatchelfHook, stdenv }:

stdenv.mkDerivation {
  pname = "imgui";
  version = "v0.9.3.1";

  # dontUnpack = true;

  src = pkgs.fetchurl {
    url =
      "https://github.com/cfillion/reaimgui/releases/download/v0.9.3.1/reaper_imgui-x86_64.so";
    sha256 = "sha256-B9nSuFtPz2e9/gF9AYx7VT6XCaVvL/idUFh+0nRA/Mw=";
  };

  nativeBuildInputs = [ autoPatchelfHook ];
  # buildInputs = [ ];

  installPhase = ''
    mkdir -p $out/lib
    cp -r . $out/lib
  '';
}
