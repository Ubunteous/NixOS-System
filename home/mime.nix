{ pkgs, home-manager, user, ... }:

############
#   MIME   #
############

{
  # Manage mimes:

  # 1: xdg-mime query filetype <file>
  
  # 2: *.desktop files located in the following directories:
  # /run/current-system/sw/share/applications
  # /etc/profiles/per-user/<username>/share/applications

  # 3: either use xdg-mime default <program>.desktop <mimetype> or the following home manager configuration

  # Debug mimes:

  # XDG_UTILS_DEBUG_LEVEL=2 xdg-mime query filetype <file>
  
  home-manager.users.${user} = {
    # rewrite mimeapps even if nemo messes with it
    xdg.configFile."mimeapps.list".force = true;
    
    xdg.mime.enable = true;

    xdg.mimeApps = {
      enable = true;

      # if defaultApplications does not suffice, try also associations.added
      defaultApplications = {
        # images
        "image/png" = "pix.desktop";
        "image/jpg" = "pix.desktop";
        "image/jpeg" = "pix.desktop";
        "image/svg+xml" = "pix.desktop";
        "image/x-nikon-nef" = "darktable.desktop";
        "image/x-xcf" = "gimp.desktop";

        # consult in firefox
        "application/pdf" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";

        # text
        "application/x-shellscript" = "xed.desktop";
        "text/x-python" = "xed.desktop";
        "text/plain" = "xed.desktop";
        "application/vnd.ms-publisher" = "xed.desktop";

        # archives
        "application/zip" = "org.gnome.FileRoller.desktop";
        "application/vnd.rar" = "org.gnome.FileRoller.desktop";
        
        "application/vnd.comicbook-rar" = "YACReader.desktop";
        "application/vnd.comicbook+zip" = "YACReader.desktop";

      };
    };
  };
}
