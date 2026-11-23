{
  lib,
  stdenv,
  fetchzip,
  dpkg,
  autoPatchelfHook,
  makeWrapper,
}:

stdenv.mkDerivation {
  name = "tx16wx";

  src = fetchzip {
    url = "https://www.tx16wx.com/download/tx16wx-software-sampler-3-linux-x64-debian-2/?wpdmdl=19516&refresh=6b0309e9799291795361257";
    hash = "";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    dpkg
    makeWrapper
  ];

  buildInputs = [ ];

  unpackPhase = ''
    runHook preUnpack

    echo "Starting unpack phase"
	ls -la
    dpkg-deb -x "$src" unpack

    # tx16wx-software-sampler-{version}-amd64.deb
    # for deb in $src/*.deb; do
    #   dpkg-deb -x "$deb" pkgs
    # done

    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    cp lib $out
    cp share $out
  '';
}
