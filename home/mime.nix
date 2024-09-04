{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.home.mime;
  homecfg = config.home;
  in {
    options.home.mime = { enable = mkEnableOption "Enable support for Mime"; };

    config = mkIf (homecfg.enable && cfg.enable) {
    ############
    #   MIME   #
    ############

    # Manage mimes:

    # 1: xdg-mime query filetype <file>

    # 2: *.desktop files located in the following directories:
    # /run/current-system/sw/share/applications
    # /etc/profiles/per-user/<username>/share/applications

    # 3: either use xdg-mime default <program>.desktop <mimetype> or the following home manager configuration

    # Debug mimes:

    # XDG_UTILS_DEBUG_LEVEL=2 xdg-mime query filetype <file>

    # rewrite mimeapps even if nemo messes with it
    xdg.configFile."mimeapps.list".force = true;

    xdg.mime.enable = true;

    xdg.mimeApps = {
      enable = true;

      # if defaultApplications does not suffice, try also associations.added
      defaultApplications = {
        # dir
        "inode/directory" = "nemo.desktop";
        # images
        "image/png" = "pix.desktop";
	"image/avif" = "pix.desktop";
        "image/jpg" = "pix.desktop";
        "image/jpeg" = "pix.desktop";
        "image/svg+xml" = "pix.desktop";
        "image/x-nikon-nef" = "darktable.desktop";
        "image/x-xcf" = "gimp.desktop";

        # consult in firefox
        "application/pdf" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "text/html" = "firefox.desktop";

        # text
        "application/x-shellscript" = "xed.desktop";
        "text/x-python" = "xed.desktop";
        "text/plain" = "xed.desktop";
        "application/vnd.ms-publisher" = "xed.desktop";
        "application/xml" = "xed.desktop";

        # archives
        "application/zip" = "org.gnome.FileRoller.desktop";
        "application/vnd.rar" = "org.gnome.FileRoller.desktop";

        "application/vnd.comicbook-rar" = "YACReader.desktop";
        "application/vnd.comicbook+zip" = "YACReader.desktop";
      };
    };
  };
}
