{
  lib,
  stdenv,
  fetchurl,
  dpkg,
  autoPatchelfHook,
  makeWrapper,
}:

stdenv.mkDerivation {
  name = "tx16wx";

  src = fetchurl {
    url = "https://www.tx16wx.com/download/tx16wx-software-sampler-3-linux-x64-debian-2/?wpdmdl=19516";
    hash = "sha256-A8jEIunbW+hcqvnslhKt0WEInG9dO7lsffGm3Z2eLVM=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    dpkg
    makeWrapper
  ];

  unpackPhase = ''
	runHook preUnpack
    dpkg-deb -x "$src" unpack
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/{lib,share}
    cp -r unpack/usr/lib $out/lib
    cp -r unpack/usr/share $out
  '';
}
