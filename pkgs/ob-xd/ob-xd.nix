{ stdenv, pkgs, name }: # url, sha256

stdenv.mkDerivation {
  inherit name;

  # src = pkgs.fetchurl { inherit url sha256; };
  src = pkgs.fetchurl {
    url = "https://demo.discodsp.com/Obxd37Linux.zip";
    sha256 = "sha256-X3jt/ZlbWF1Opv2E1BonmWRJPH5yuMQdu36ms5xKJP8=";
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
