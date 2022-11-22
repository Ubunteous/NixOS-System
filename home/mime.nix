{ pkgs, home-manager, user, ... }:

############
#   MIME   #
############

{

  home-manager.users.${user} = {
    # rewrite mimeapps even if nemo messes with it
    xdg.configFile."mimeapps.list".force = true;

    xdg.mime.enable = true;

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "image/png" = "pix.desktop";
        "image/jpg" = "pix.desktop";
        "image/jpeg" = "pix.desktop";

        "application/pdf" = "firefox.desktop";
        "application/x-shellscript" = "xed.desktop";
        "text/x-python" = "xed.desktop";
        "text/plain" = "xed.desktop";

        "application/vnd.ms-publisher" = "xed.desktop";
      };
    };
  };
}
