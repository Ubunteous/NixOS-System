{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  cairo,
  libepoxy,
  gtk3,
}:

stdenv.mkDerivation rec {
  pname = "reaimgui";
  version = "0.9.3.2";

  src = fetchurl {
    url = "https://github.com/cfillion/reaimgui/releases/download/v${version}/reaper_imgui-x86_64.so";
    hash = "sha256-LNeek0+LXueqIR/8szpfPURCJdMw6UfEtip6ESDiPqQ=";
  };

  dontUnpack = true;

  nativeBuildInputs = [ autoPatchelfHook ];

  buildInputs = [
    cairo
    libepoxy
    gtk3
    stdenv.cc.cc.lib
  ];

  installPhase = ''
    runHook preInstall
    install -Dm755 $src $out/UserPlugins/reaper_imgui-x86_64.so
    runHook postInstall
  '';

  meta = {
    description = "Dear ImGui bindings for REAPER's ReaScript API";
    homepage = "https://github.com/cfillion/reaimgui";
    license = lib.licenses.lgpl3Plus;
    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
}
