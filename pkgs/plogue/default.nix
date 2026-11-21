{
  pkgs ? import <nixpkgs> { },
}:

{
  # sforzando = pkgs.callPackage ./plogue.nix {
  #   name = "sforzando";
  #   version = "1.982";
  #   url = "https://sforzando.s3.us-east-1.amazonaws.com/LINUX_plogue-sforzando_1.982_x86_64.zip";
  #   hash = "sha256-Qcwv5DgReNxA68CWosvIwZkhDAxnc5/A15lmlc/Mr3M=";
  # };

  ops7 = pkgs.callPackage ./plogue.nix {
    name = "chipsynth OPS7";
    version = "1.132";
    url = "https://s3.amazonaws.com/chipsynth/LINUX_plogue-chipsynth-ops7_1.132_x86_64.zip";
    hash = "sha256-vQXPZyc/qT+/j0KtBvS5mxgcpl/2jdQMI0Bz1p3d8xE=";
  };
}
