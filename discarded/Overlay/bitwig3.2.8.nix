{ config, pkgs, lib, ... }:

{
  nixpkgs.overlays = [(
    self: super:
    {
      bitwig-studio3 = super.bitwig-studio3.overrideAttrs (old: rec {
        # "https://downloads.bitwig.com/stable/3.2.8/bitwig-studio-3.2.8.deb";
        pname = "bitwig-studio";
        version = "3.2.8";
        
        src = super.fetchurl {
          # If you don't know the hash, the first time, do:
          # curl www.google.com | sha256sum
          sha256 = "f24227ce350ea725f3691cd2cae3a56a29e2ae9c0821c82a592faeb36d7d8da2";
        };

        buildInputs = [ pkgs.pixman ];
      });
    }
  )];
}
