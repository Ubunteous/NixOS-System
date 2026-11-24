# rb7b9z6x2pv7q3cj74z5rapn6za52d09-tx16wx/clap/TX16Wx.clap
# fvzm7ibrdgfx3hpdgxdkwampmillvrsx-tx16wx/lib/lib/clap/TX16Wx.clap
# 7cpih7n62fs5lzg59ww0yc3s9bjx7rji-tx16wx/lib/lib/clap/TX16Wx.clap
# gm4f56l7355q2xmsk83q2jfira9wmh01-tx16wx/lib/lib/clap/TX16Wx.clap

{
  stdenv,
  fetchurl,
  dpkg,
  autoPatchelfHook,
  makeWrapper,
  #
  libxcb,
  libxcb-util,
  xcbutilxrm,
  libgcc,
  libxcb-cursor,
  libxkbcommon,
  pango,
  cairo,
  harfbuzz,
  fontconfig,
  freetype,
  liburing,
  libsecret,
  glib,
  libuuid,
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

  buildInputs = [
    libxcb
    libxcb-util
    xcbutilxrm
    libgcc
    libxcb-cursor
    libxkbcommon
    pango
    cairo
    harfbuzz
    fontconfig
    freetype
    liburing
    libsecret
    glib
    libuuid
  ];

  unpackPhase = ''
    runHook preUnpack
    dpkg-deb -x "$src" unpack
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib
    cp -r unpack/usr/lib/{vst,vst3,clap} $out/lib
    cp -r unpack/usr/share $out
  '';
}
