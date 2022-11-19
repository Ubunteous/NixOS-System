{ pkgs, home-manager, user, ... }:

############
#   MIME   #
############

{
  home-manager.users.${user} = {
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
