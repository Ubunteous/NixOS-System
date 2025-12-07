{ stdenv, pkgs, name, url, sha256 }:

stdenv.mkDerivation {
  inherit name;

  src = pkgs.fetchzip { inherit url sha256; };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/lib/{lv2,vst,vst3}

    cp -r Linux/Linux-64b-LV2-FREE/* $out/lib/lv2/
    # cp -r Linux/Linux-64b-VST2-FREE/* $out/lib/vst/ # removed since selene in 12/25
    cp -r Linux/Linux-64b-VST3-FREE/* $out/lib/vst3/
  '';
}
