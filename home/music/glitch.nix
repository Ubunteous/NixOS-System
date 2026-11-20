{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.home.music.glitch;
  homecfg = config.home;

  glitch = (pkgs.callPackage ../../pkgs/glitch/glitch.nix { });
in
{
  options.home.music.glitch = {
    enable = mkEnableOption "Enable support for the glitch plugin";
  };

  config = mkIf (homecfg.enable && cfg.enable) {
    home.packages = [ glitch ];

    # these folders can be placed anywhere
    xdg.configFile."glitch/Glitch2_Presets" = {
      source = "${glitch}/lib/extra/Glitch2_Presets";
      recursive = true;
    };

    xdg.configFile."glitch/Glitch2_User_Guide.pdf".source =
      "${glitch}/lib/extra/Glitch2_User_Guide.pdf";
  };
}
