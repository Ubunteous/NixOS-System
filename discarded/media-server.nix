let mediaDir = "/var/lib/media";
in {
  users.groups = {
    streamer = { };
    torrenter = { };
    media = { members = [ "radarr" "sonarr" "bazarr" "plex" "zmitchell" ]; };
  };
  users.users = {
    streamer = {
      isSystemUser = true;
      group = "streamer";
    };
    torrenter = {
      isSystemUser = true;
      group = "torrenter";
    };
  };

  # create server directories
  systemd.tmpfiles.rules = [
    "d ${mediaDir} 0775 root media -"
    "d ${mediaDir}/library/Movies 0775 streamer media -"
    "d ${mediaDir}/library/TV 0775 streamer media -"
    "d ${mediaDir}/library/Audiobooks 0775 streamer media -"
    "d ${mediaDir}/torrents 0775 torrenter media -"
    "d ${mediaDir}/torrents/.incomplete 0775 torrenter media -"
    "d ${mediaDir}/torrents/.watch 0775 torrenter media -"
    "d ${mediaDir}/torrents/radarr 0775 torrenter media -"
    "d ${mediaDir}/torrents/sonarr 0775 torrenter media -"
    "d ${mediaDir}/torrents/bazarr 0775 torrenter media -"
  ];
}
