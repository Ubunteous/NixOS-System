{ config, lib, ... }:

with lib;
let
  cfg = config.lab.minecraft;
  labcfg = config.lab;
in {
  options.lab.minecraft = {
    enable = mkEnableOption "Enables Minecraft server";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.minecraft-server = {
      enable = true;

      eula = true;
      declarative = true;
      openFirewall = true;

      # needs declarative and serverProperties white-list 
      # whitelist = {
      # 	username1 = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx";
      # 	username2 = "yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy";
      # };

      serverProperties = {
        white-list = true;

        gamemode = 1;
        difficulty = 3;
        max-players = 4;
        # server-port = 43000; # default is 25565
        motd = "NixOS Minecraft server!";

        enable-rcon = true;
        "rcon.password" = "hunter2";
      };

      # dataDir = "/var/lib/minecraft";
      # jvmOpts = "-Xmx2048M -Xms2048M";
      # package = pkgs.minecraft-server;
    };
  };
}
