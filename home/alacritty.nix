{ pkgs, home-manager, user, ... }:

#################
#   ALACRITTY   #
#################

{
  home-manager.users.${user} = {
    programs.alacritty = {
      enable = true;
      settings = {
        font.size = 14.0;

        draw_bold_text_with_bright_colors = true;

        # Cyberpunk-Neon colours
        colors = {
          primary = {
            background = "0x000b1e";
            foreground = "0x0abdc6";
          };

          # Default colours

          # Colors that should be used to draw the terminal cursor. If these are unset, the cursor colour will be the inverse of the cell colour.

          # cursor = {
          # text = "0x2e2e2d";
          # text: '0x000000'
          # cursor = "0xffffff";
          
          # Normal colors
          normal = {
            black = "0x123e7c";
            red = "0xff0000";
            green = "0xd300c4";
            yellow = "0xf57800";
            blue = "0x123e7c";
            magenta = "0x711c91";
            cyan = "0x0abdc6";
            white = "0xd7d7d5";
          };

          
          # Bright colors
          bright = {
            black = "0x6095FD";
            red = "0xff0000";
            green = "0xd300c4";
            yellow = "0xf57800";
            blue = "0x00ff00";
            magenta = "0x711c91";
            cyan = "0x0abdc6";
            white = "0xd7d7d5";
          };

          # dim colors
          dim = {
            black = "0x6095FD";
            red = "0xff0000";
            green = "0xd300c4";
            yellow = "0xf57800";
            blue = "0x123e7c";
            magenta = "0x711c91";
            cyan = "0x0abdc6";
            white = "0xd7d7d5";
          };
        };
      };
    };
  };
}
