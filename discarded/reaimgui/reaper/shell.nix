with import <nixpkgs> { };
mkShell {
  NIX_LD_LIBRARY_PATH = lib.makeLibraryPath [
    autoPatchelfHook
    # nix-shell -p cairo libepoxy gtk3 autoPatchelfHook --run 'autoPatchelf ./reaper_imgui-x86_64.so'
    freetype
    libpng
    libz

    fontconfig
    libepoxy
    gtk3

    # libgdk-3.so.0
    # libm.so.6

    cairo

    glib # libgobject-2.0.so.0

    stdenv.cc.cc.lib # libstdc++.so.6
    libgcc
    glibc # libc
  ];
  NIX_LD = lib.fileContents "${stdenv.cc}/nix-support/dynamic-linker";
}
