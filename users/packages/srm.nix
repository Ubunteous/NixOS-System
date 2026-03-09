{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.user.packages.srm;
  usercfg = config.user;
in {
  options.user.packages.srm = {
    enable = mkEnableOption "Enable srm packages";
  };

  config = mkIf (usercfg.enable && cfg.enable) {
    users.users.${user}.packages = with pkgs; [
      # jetbrains.rider
      # mkdocs
      # msbuild
      # thunderbird
      # ventoy-bin
      discord
      gdu
      nextcloud-client
      openvpn
      sqlcmd
      tmux
    ];
  };
}

