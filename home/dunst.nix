{ config, lib, pkgs, home-manager, user, ... }:

with lib;
let
  cfg = config.home.dunst;
in
{
  options.home.dunst = {
    enable = mkEnableOption "Enable support for Dunst";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user} = {
      #############
      #   DUNST   #
      #############

      # custom picture
      # dunstify -i ~/Pictures/picture.png "Text after the picture"

      # urgency
      # dunstify -u low "Lower urgency than normal or critical"

      # time before disappearance
      # dunstify -t 1000 "Leaves in one second"

      # sound notification with bar
      # dunstify -h string:x-dunst-stack-tag:"Brightness" -h int:value:$(pamixer --get-volume-human) "Brightness"

      # https://gvolpe.com/blog/xmonad-polybar-nixos/
      services.dunst = {
        enable = true;
        # iconTheme = {
        #   name = "Papirus-Dark";
        #   package = pkgs.papirus-icon-theme;
        #   size = "32x32";
        # name = "Adwaita";
        # package = pkgs.gnome3.adwaita-icon-theme;
        # };
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
            corner_radius = 10;
            width = 300;
            # class = "dock";

            # Align icons left/right/off
            # icon_position = "left";

            # Scale larger icons down to this size, disable with  0
            # max_icon_size = 32;
            
            frame_color = "#8CAAEE";
            separator_color = "frame";
          };
          
          urgency_low = {
            background = "#303446";
            foreground = "#C6D0F5";
            highlight = "#f5a97f"; # peach
          };

          urgency_normal = {
            background = "#303446";
            foreground = "#C6D0F5";
            highlight = "#c6a0f6"; # mauve
          };
          
          urgency_critical = {
            background = "#303446";
            foreground = "#C6D0F5";
            frame_color = "#EF9F76";
            highlight = "#ed8796"; # red
          };
        };
      };
    };
  };
}
