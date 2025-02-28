{ lib, ... }:

with lib; {
  options.lab.enable = mkEnableOption "Homelab configuration";
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

    ./backup/borg.nix
    ./backup/immich.nix
    ./backup/restic.nix
    ./backup/rsyncd.nix
    ./backup/syncthing.nix
    ./backup/filebrowser.nix

    ./self-hosted/homepage.nix
    # ./self-hosted/shiori.nix

    ./dns/adguard.nix
    ./dns/unbound.nix
    ./dns/bind.nix

    ./vpn/wireguard.nix
    ./vpn/authelia.nix
    ./vpn/fail2ban.nix
  ];
}
