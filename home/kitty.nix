{ pkgs, home-manager, user, ... }:

#############
#   KITTY   #
#############

{
  home-manager.users.${user} = {
    programs.kitty = {
      enable = true;
      theme = "Fish Tank";
      
      settings = {
        font_size = 24;
        shell = "fish";
        cursor_blink_interval = 0;

        enable_audio_bell = false;
        update_check_interval = 0;
        confirm_os_window_close = 0;
        focus_follow_mouse = "yes";
        # font
      };
    };
  };
}
