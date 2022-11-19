{ pkgs, home-manager, user, ... }:

#############
#   DUNST   #
#############

{
  home-manager.users.${user} = {

    # https://gvolpe.com/blog/xmonad-polybar-nixos/
    services.dunst = {
      enable = true;
      iconTheme = {
        # name = "Latte";
        # package = pkgs.catppuccin-gtk;
        name = "Adwaita";
        package = pkgs.gnome3.adwaita-icon-theme;
        # size = "32x32";
      };
      settings = {
        global = {
          # monitor = 0;
          geometry = "600x50-50+65";
          shrink = "yes";
          transparency = 10;
          padding = 16;
          horizontal_padding = 16;
          font = "JetBrainsMono Nerd Font 10";
          line_height = 4;
          format = ''<b>%s</b>\n%b'';
          alignment = "center";
          # corner_radius = 0;
          # class = "dock";

          frame_color = "#8CAAEE";
          separator_color = "frame";
        };
        
        urgency_low = {
          background = "#303446";
          foreground = "#C6D0F5";
        };

        urgency_normal = {
          background = "#303446";
          foreground = "#C6D0F5";
        };
        
        urgency_critical = {
          background = "#303446";
          foreground = "#C6D0F5";
          frame_color = "#EF9F76";
        };
      };
    };
  };
}
