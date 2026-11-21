{
  lib,
  stdenv,
  fetchzip,
  dpkg,
  autoPatchelfHook,
  makeWrapper,
  alsa-lib,
  cairo,
  curl,
  glib,
  gtk3,
  gtkmm3,
  libpulseaudio,
  pango,
  xcbutil,
  libxcb-cursor,
  zenity,
  #
  name,
  url,
  hash,
  version,
}:

let
  nameWithoutSpace =
    if name == "chipcrusher" then "chipcrusher2" else "${builtins.replaceStrings [ " " ] [ "-" ] name}";
in
  stdenv.mkDerivation {
	pname = nameWithoutSpace;
	inherit version;

	src = fetchzip { inherit url hash; };

	nativeBuildInputs = [
      autoPatchelfHook
      dpkg
      makeWrapper
	];

	buildInputs = [
      alsa-lib
      cairo
      curl
      glib
      gtk3
      gtkmm3
      libpulseaudio
      pango
      xcbutil
      libxcb-cursor
	];

	unpackPhase = ''
      runHook preUnpack
      for deb in $src/*.deb; do
        dpkg-deb -x "$deb" pkgs
      done
      runHook postUnpack
    '';

	installPhase = ''
      runHook preInstall

      mkdir -p "$out/Plogue"
      cp -r "pkgs/opt/Plogue/${name}"    "$out/Plogue/"

      if [ -d pkgs/opt/Plogue/TableWarp ]; then
        cp -r pkgs/opt/Plogue/TableWarp "$out/Plogue/"
	  fi

      if [ -d pkgs/opt/Plogue/Aria ]; then
        cp -r pkgs/opt/Plogue/Aria       "$out/Plogue/"

        # Patch hardcoded /opt/Plogue paths inside the .config JSON files.
        # The Aria engine reads these to locate libAria.so and its resources.
        sed -i "s|/opt/Plogue/Aria|$out/Plogue/Aria|g"           "$out/Plogue/Aria/.config"
	  fi

      if [ -d pkgs/opt/Plogue/Fermata ]; then
        cp -r pkgs/opt/Plogue/Fermata       "$out/Plogue/"

        # TODO: probably needed (like Aria above). worth checking out later
        sed -i "s|/opt/Plogue/Fermata|$out/Plogue/Fermata|g"           "$out/Plogue/Fermata/.config"
      fi

      sed -i "s|/opt/Plogue/${name}|$out/Plogue/${name}|g" "$out/Plogue/${name}/.config"

      # TODO: does not work without a home manager module. Somehow, reaper finds the .clap version
      # mkdir -p "$out/lib/vst3"
      # cp -r "pkgs/usr/lib/vst3/${nameWithoutSpace}.vst3" "$out/lib/vst3/"

      mkdir -p "$out/lib/clap"
      cp "pkgs/usr/lib/clap/${nameWithoutSpace}.clap" "$out/lib/clap/"

      # TODO: check if all appear or only the most recent one
      if [ ${name} != "chipcrusher" ]; then
        mkdir -p "$out/share/applications" "$out/share/icons/hicolor/256x256/apps"
        cp "pkgs/usr/share/applications/plogue-${nameWithoutSpace}.desktop" \
           "$out/share/applications/"
        cp "pkgs/usr/share/icons/hicolor/256x256/apps/plogue-${nameWithoutSpace}.png" \
           "$out/share/icons/hicolor/256x256/apps/"
        substituteInPlace "$out/share/applications/plogue-${nameWithoutSpace}.desktop" \
          --replace 'Exec="/opt/Plogue/${name}/${nameWithoutSpace}"' 'Exec="$out/bin/${name}"'

        mkdir -p "$out/bin"
        makeWrapper "$out/Plogue/${name}/${nameWithoutSpace}" "$out/bin/${name}" \
          --prefix PATH : ${lib.makeBinPath [ zenity ]}
      fi

      runHook postInstall
	'';

	# Teach autoPatchelfHook to find libAria.so/libFermata.so when patching the VST3/CLAP plugins.
	preFixup = ''
	  if [ -d $out/Plogue/Aria ]; then
        addAutoPatchelfSearchPath "$out/Plogue/Aria"
      fi

	  if [ -d $out/Plogue/Fermata ]; then
        addAutoPatchelfSearchPath "$out/Plogue/Fermata"
      fi
	'';
  }
