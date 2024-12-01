{ config, lib, user, pkgs, ... }:

# with lib;

let cfg = config.programs.qbittorrent;
in {
  options.programs.qbittorrent = {
    enable = lib.mkEnableOption "qBittorrent";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.qbittorrent;
      defaultText = lib.literalExpression "pkgs.qbittorrent";
      description = "The qBittorrent package to install.";
    };

    # settings = mkOption {
    #   type = lib.types.str;
    #   default = "default";
    #   example = literalExpression ''
    #     bla bla bla
    #   '';
    #   description = ''
    #     Configuration written to
    #     {file}`$XDG_CONFIG_HOME/qBittorrent/qBittorrent.conf`
    #   '';
    # };

  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];

    # lib.mkIf (cfg.settings != { }) {

    # xdg.configFile."qBittorrent/qBittorrent.conf-test".text = ''
    #   r
    #   s
    # '';
  };
}
