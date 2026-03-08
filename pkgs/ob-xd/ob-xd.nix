{ stdenv, pkgs }: # name, url, sha256

stdenv.mkDerivation {
  # inherit name;
  # src = pkgs.fetchurl { inherit url sha256; };

  name = "ob-xd";

  src = pkgs.fetchurl {
    url =
      "https://github.com/surge-synthesizer/OB-Xf/releases/download/Nightly/obxf-2026-02-20-b34831b-Linux.zip";
    sha256 =
      "sha256-8665cad517b7e196f5cf3919dbdc6a852bbb4dbc6be284e46a98c272e108c9c9=";
  };

  dontBuild = true;
  sourceRoot = ".";
  buildInputs = [ pkgs.unzip ];

  installPhase = ''
    mkdir -p $out/lib
    mkdir -p $out/lib/{vst,vst3}

    mv "OB-Xd 3.so" $out/lib/vst
    mv "OB-Xd 3.vst3" $out/lib/vst3

    # note: without home manager, you need to perform this manually:
    # mv "discoDSP/" "/home/$user/Documents/"
  '';
}
