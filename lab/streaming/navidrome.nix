{ config, lib, ... }:

with lib;
let
  cfg = config.lab.navidrome;
  corecfg = config.lab;
in {

  options.lab.navidrome = {
    enable = mkEnableOption "Enables support for Navidrome";
  };

  config = mkIf (corecfg.enable && cfg.enable) {
    services.navidrome = {
      enable = true;

      openFirewall = true;

      settings = {
        Port = 4533;
        Address = "0.0.0.0"; # 127.0.0.1";

        MusicFolder = labcfg.dataDir + "media/musics";
        # DataFolder = "/var/servarr/navidrome/data"; # bad idea?
        # BaseUrl = "music"; # for proxy: https://music.example.com
        # Backup.Count = 3;
      };

      # user = "navidrome";
      # group = "navidrome";
    };
  };
}
