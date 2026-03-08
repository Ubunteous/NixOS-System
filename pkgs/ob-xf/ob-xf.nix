{ stdenv, pkgs }:

stdenv.mkDerivation {
  name = "OB-Xf";

  src = pkgs.fetchurl {
    url =
      "https://github.com/surge-synthesizer/OB-Xf/releases/download/Nightly/obxf-2026-02-20-b34831b-Linux.zip";
    sha256 = "sha256-hmXK1Re34Zb1zzkZ29xqhSu7Tbxr4oTkapjCcuEIyck=";
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
