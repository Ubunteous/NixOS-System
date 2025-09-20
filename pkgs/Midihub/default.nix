{ appimageTools, fetchurl }:

let
  pname = "midihub";
  version = "1.15.3"; # update later to 1.16.0

  src = fetchurl {
    url = "https://blokas.io/midihub/downloads/latest/linux/";
    hash = "sha256-E0Hh3YQiJF8LaoRPwMF1Q3Wr8uqQxZ92XAzACw01gYs=";
  };
in appimageTools.wrapType2 { inherit pname version src; }
