# https://github.com/NixOS/nixpkgs/tree/master/doc/stdenv
# https://github.com/NixOS/nixpkgs/tree/master/doc/languages-frameworks

# 1) unpackPhase
# requires nativeBuildInputs = [ unzip ] to unpack zipped files

# cd $sourceRoot # $sourceRoot is created in unpack phase
# => see https://nixos.org/manual/nixpkgs/stable/#ssec-unpack-phase for details.

# 2) patchPhase

# 3) configurePhase (like ./configure or cmake)
# to use cmake, requires nativeBuildInputs = [ cmake ]

# 4) buildPhase (like make)

# 5) preInstallPhase (skip with doCheck=false)
# 6) installPhase # (like make install. Adds $out dir. See it with tree $out)
# 7) postInstallPhase

# 8) fixupPhase (cleaning, avoid with dontFixup = true)

# # unpackPhase
# nativeBuildInputs = [ ];
# buildInputs = [ ];

# option 1)
# { config, pkgs, ... }: {
# Use this package directly
# environment.systemPackages = [ (pkgs.callPackage ./example-package.nix { })   ];

# option 2)
# environment.systemPackages = let examplePackage = pkgs.callPackage ./example-package.nix { };
# in [ examplePackage ]; }

# cp -r --update=none /etc/profiles/per-user/${USER}/lib/vst3/apQualizr2/{ColorSchemes,LfoCurves,Presets,'apQualizr2 Manual.pdf'} /home/$USER/.config/apulSoft/apQualizr2/

{
  stdenv,
  pkgs,
  name,
  url,
  sha256,
}:

stdenv.mkDerivation {
  inherit name;
  src = pkgs.fetchzip { inherit url sha256; };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/lib/vst3
    cp -r ./$name/ $out/lib/vst3
  '';
}
