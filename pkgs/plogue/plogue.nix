{
  stdenv,
  pkgs,
  name,
  url,
  sha256,
}:

stdenv.mkDerivation {
  inherit name;

  src = pkgs.fetchzip {
    inherit url sha256;
  };

  dontBuild = true;

  unpackPhase = ''
    echo "unpack"
        ls -la
        # dpkg-deb --fsys-tarfile $src | \
        # tar -x --no-same-owner
        # mv usr $out
  '';

  installPhase = ''
    echo "install"
        ls -la
        # mkdir -p $out/lib/{vst,vst3}

        # cp *.so $out/lib/vst
        # cp -r *.vst3 $out/lib/vst3
  '';
}
