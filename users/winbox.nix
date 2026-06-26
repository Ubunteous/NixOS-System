{ config, lib, ... }:

with lib;
let
  cfg = config.user.winbox;
  usercfg = config.user;
in
{
  options.user.winbox = {
    enable = mkEnableOption "Enable winbox";
  };

  config = mkIf (usercfg.enable && cfg.enable) {
    programs.winbox = {
      enable = true;
      # package = pkgs.winbox;
      openFirewall = true;
    };
  };
}
