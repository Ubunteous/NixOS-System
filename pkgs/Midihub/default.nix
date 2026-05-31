{ appimageTools, fetchurl }:

let
  pname = "midihub";
  version = "1.15.3"; # update later to 1.16.0

  src = fetchurl {
    url = "https://blokas.io/midihub/downloads/latest/linux/";
    hash = "sha256-Fn6YqmwyH+I3YcY5RhQQXUAefczhc+LQX/0imK2cJjs=";
  };
in appimageTools.wrapType2 { inherit pname version src; }
