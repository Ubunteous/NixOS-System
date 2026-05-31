{ stdenv, pkgs }:

stdenv.mkDerivation {
  name = "OB-Xf";

  src = pkgs.fetchurl {
    url =
      "https://github.com/surge-synthesizer/OB-Xf/releases/download/v1.0.3/ob-xf-Linux-v1.0.3.zip";
    sha256 = "sha256-crYMg89kJjNwMd90TDSgRxBKnZXx/q9s0Ejs+jn3TJY=";
  };

  dontBuild = true;
  sourceRoot = ".";
  buildInputs = [ pkgs.unzip ];

  installPhase = ''
    mkdir -p $out/lib
    mkdir -p $out/lib/{clap,lv2,vst3}

    mv "obxf_products/OB-Xf.clap" $out/lib/clap
    mv "obxf_products/OB-Xf.lv2" $out/lib/lv2
    mv "obxf_products/OB-Xf.vst3" $out/lib/vst3
  '';
}
