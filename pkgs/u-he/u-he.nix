{
  pkgs,
  autoPatchelfHook,
  stdenv,
  gtk3,
  name,
  url,
  sha256,
}:

stdenv.mkDerivation {
  inherit name;
  src = pkgs.fetchurl { inherit url sha256; };

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [
    gtk3
    pkgs.libxcb-keysyms
    pkgs.libxcb-cursor
    pkgs.libxcb-util
  ];

  installPhase = ''
    mkdir -p $out/lib/${name}

    # maybe also unlink PresetDatabase/UserPresets
    # rm -r ./${name}/Presets &&
    cp -r . $out/lib

    # cp "./${name}/${name}.64.so" "$out/lib/${name}/${name}.64.so"
    # cp "./${name}/dialog" "$out/lib/${name}/dialog"
    # cp "./${name}/dialog.64" "$out/lib/${name}/dialog.64"
  '';
}
