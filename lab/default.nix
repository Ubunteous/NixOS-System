{ lib, ... }:

with lib;
# let cfg = config.lab; in # add to inputs if uncomment
{
  options.lab = {
    enable = mkEnableOption "Homelab configuration";

    git = {
      enable = mkEnableOption "Git utilities";

      webUI = mkOption {
        type = types.enum [ "gitea" "gitweb" "cgit" ];
        default = null;
        description = "Git web UI used (gitea, gitweb or cgit)";
      };

      repoDir = mkOption {
        type = types.path;
        default = "/var/www/git";
        description = lib.mdDoc "The directory where media is stored";
      };
    };

    mkDataDir = mkEnableOption "Create directory for media";

    dataDir = mkOption {
      type = types.path;
      default = "/var/data/";
      description = lib.mdDoc "The directory where media is stored";
    };
  };

  imports = [
    ./sysadmin/ssh.nix
    ./sysadmin/k3s.nix
    ./sysadmin/podman.nix
    # ./sysadmin/virtual-box.nix

    # ./monitoring/grafana.nix
    # ./monitoring/prometheus.nix
    # ./monitoring/loki.nix

    ./proxy/caddy.nix
    # ./proxy/nginx.nix
    # ./proxy/traefik.nix

    ./streaming/kodi.nix
    ./streaming/plex.nix
    ./streaming/jellyfin.nix
    ./streaming/jellyseer.nix
    ./streaming/tautulli.nix
    # ./streaming/kavita.nix
    ./streaming/navidrome.nix
    ./streaming/komga.nix
    ./streaming/immich.nix

    ./servarr/sonarr.nix
    ./servarr/radarr.nix
    # ./servarr/readarr.nix
    ./servarr/lidarr.nix
    ./servarr/bazarr.nix
    ./servarr/prowlarr.nix
    # ./servarr/flaresolverr.nix

    ./downloaders/qbittorrent.nix
    # ./downloaders/deluge.nix
    # ./downloaders/transmission.nix
    # ./downloaders/rtorrent.nix
    # ./downloaders/rutorrent.nix
    # ./downloaders/flood.nix
    # ./downloaders/nzbget.nix
    # ./downloaders/sabnzbd.nix
    ./downloaders/soulseek.nix

    ./backup/gitea.nix
    ./backup/cgit.nix
    ./backup/gitweb.nix
    ./backup/gitdaemon.nix
    ./backup/borg.nix
    ./backup/restic.nix
    ./backup/rsyncd.nix
    # ./backup/sanoid.nix
    # ./backup/syncoid.nix
    ./backup/syncthing.nix
    ./backup/filebrowser.nix

    ./self-hosted/homepage.nix
    # ./self-hosted/shiori.nix
    # ./self-hosted/minecraft.nix

    ./dns/adguard.nix
    ./dns/unbound.nix
    ./dns/bind.nix

    ./vpn/wireguard.nix
    ./vpn/authelia.nix
    ./vpn/fail2ban.nix
  ];

  # config = let dirs = [ "films" "series" "musics" "books" "comics" ];
  # in mkIf (cfg.enable && cfg.mkDataDir && builtins.pathExists cfg.dataDir) {
  #   systemd.tmpfiles.rules = [ "d ${cfg.dataDir} 0777 root" ]
  #     ++ map (dir: "d ${cfg.dataDir}/media/${dir} 0777 root") dirs
  #     ++ map (dir: "d ${cfg.dataDir}/downloads/${dir} 0777 root") dirs;
  # };
}
