{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.user.steam;
  usercfg = config.user;
in {
  options.user.steam = { enable = mkEnableOption "Install steam"; };

  config = mkIf (usercfg.enable && cfg.enable) {
    programs.steam = {
      enable = true;
      protontricks.enable = true;

      extraPackages = [ pkgs.steam-run ];

      # gamescopeSession = {
      # 	enable = true;
      # 	env = {};
      # 	args = [];
      # 	steamArgs = [ "-tenfoot" "-pipewire-dmabuf" ];
      # };

      # extest.enable = false; # enable only on wayland

      # remotePlay.openFirewall = false;
      # dedicatedServer.openFirewall = false;
      # localNetworkGameTransfers.openFirewall = false;

      # package = pkgs.steam;
      # extraPackages = [ pkgs.gamescope ];
      # protontricks.package = pkgs.protontricks;
      # extraCompatPackages = [ pkgs.pronton-ge-bin ];
      # fontPackages = builtins.filter lib.types.package.check config.fonts.packages;
    };
  };
}
