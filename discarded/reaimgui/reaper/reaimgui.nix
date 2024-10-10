{ pkgs, fetchFromGitHub, fetchgit, autoPatchelfHook, stdenv, meson, gcc, boost
, gtest, libjpeg, md4c, freetype, libpng, zlib, fontconfig, libepoxy, gtk3
, ninja, cmake, pkg-config, git, lua, imgui, cairo, stdenv }:

stdenv.mkDerivation {
  pname = "imgui";
  version = "v0.9.3.1";

  # src = fetchFromGitHub {
  #   owner = "cfillion";
  #   repo = "imgui";
  #   rev = "v0.9.3.1";
  #   sha256 = "";
  #   # url = "https://github.com/cfillion/reaimgui";
  # };

  src = fetchgit {
    url = "https://github.com/cfillion/reaimgui";
    sha256 = "sha256-pNDzJI0itE0XGA/YTuwAPDHEa5oR/Frd1BzbKKgkY1E=";
    rev = "v0.9.3.1";
  };

  nativeBuildInputs = [ autoPatchelfHook ];

  buildInputs = [
    meson
    gcc
    boost
    gtest
    libjpeg
    md4c
    freetype
    libpng
    zlib

    fontconfig
    libepoxy
    gtk3

    ninja
    cmake
    pkg-config
    git
    lua
    imgui
    cairo
    stdenv.cc.cc.lib
  ];

  # buildPhase = ''
  #   meson setup build
  #   cd build
  #   ninja
  # '';

  # meson test
  # meson install --tags runtime

  # installPhase = ''
  #   mkdir -p $out/lib
  #   cp -r . $out/lib
  # '';
}
