{ pkgs, home-manager, user, ... }:

##############
#   THEMES   #
##############

{
  home-manager.users.${user} = {
    # adapta-gtk-theme
    # arc-theme
    # dracula-theme
    # nordic # also available on firefox
    # papirus-icon-theme

    gtk = {
      enable = true;
      
      theme = {
        name = "Arc-Dark";
        package = pkgs.arc-theme;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      font = {
        name = "Noto Sans";
        package = pkgs.noto-fonts;
      };
      cursorTheme = {
        size = 36;
        name = "Nordzy-cursors";
        package = pkgs.nordzy-cursor-theme;
      };

      # gtk3.extraConfig = {        
      #   gtk-application-prefer-dark-theme = true;
      # };
    };
  };
}
