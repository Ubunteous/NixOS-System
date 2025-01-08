{ config, lib, stylix, ... }:

with lib;
let
  cfg = config.user.stylix;
  usercfg = config.user;
in {
  options.user.stylix = {
    enable = mkEnableOption "Enables support for Stylix styling";
  };

  config = mkIf (usercfg.enable && cfg.enable) {
    stylix = {
      enable = true;

      #############
      # WALLPAPER #
      #############

      image = ../files/sky.jpg;

      # "stretch", "fill", "fit", "center", "tile"
      # imageScalingMode = "fill";

      # images can be taken from the internet
      # image = pkgs.fetchurl {
      # 	url = "https://www.pixelstalk.net/wp-content/uploads/2016/05/Epic-Anime-Awesome-Wallpapers.jpg";
      # sha256 = "enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
      # };

      ###########
      # COLOURS #
      ###########

      # The colour scheme can be previewed in a web browser at either:
      # + /etc/stylix/palette.html for NixOS
      # + ~/.config/stylix/palette.html for Home Manager

      polarity = "dark";

      # it is possible to change some values with stylix.override
      # base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

      #########
      # FONTS #
      #########

      # fonts = {
      # sizes = {
      #   applications = 12;
      #   desktop = 10;
      #   popups = 10;
      #   terminal = 12;
      # };

      # 	serif = {
      # 	  package = pkgs.dejavu_fonts;
      # 	  name = "DejaVu Serif";
      # 	};

      # 	sansSerif = {
      # 	  package = pkgs.dejavu_fonts;
      # 	  name = "DejaVu Sans";
      # 	};

      # 	monospace = {
      # 	  package = pkgs.dejavu_fonts;
      # 	  name = "DejaVu Sans Mono";
      # 	};

      # 	emoji = {
      # 	  package = pkgs.noto-fonts-emoji;
      # 	  name = "Noto Color Emoji";
      # 	};
      # };

      ###########
      # TARGETS #
      ###########

      # Manually disable style with 
      # targets.<target>.enable = false;

      # forces to explicitly enable targets
      # autoEnable = false;

      ##########
      # CURSOR #
      ##########

      # name = "Vanilla-DMZ";
      # size = 32;

      ###########
      # OPACITY #
      ###########

      # opacity = {
      #   applications = 1.0;
      #   desktop = 1.0;
      #   popups = 1.0;
      #   terminal = 1.0;
      # };
    };
  };
}
