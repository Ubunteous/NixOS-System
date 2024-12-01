{ pkgs, user, ... }:

{
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

  # home.packages = with pkgs; [ hello ];

  imports = [ ../home ];

  #----------------#
  #      HOME      #
  #----------------#

  home = {
    enable = true;
    
    firefox.enable = true; # osConfig on nur breaks build
    firefox.on-nixos = false;
    
    flameshot.enable = true;
    dunst.enable = true;
    git.enable = true;
    picom.enable = true;
    themes.enable = true;
    mime.enable = true;
    u-he.enable = true;
    xautolock.enable = true;
    
    emacs.enable = true;
    nix-direnv.enable = false;
    xdg-user-dir.enable = false;

    terminal = {
      enable = true;
      
      alacritty.enable = true;
      bash.enable = true;
      fish.enable = true;
      kitty.enable = true;
      wezterm.enable = true;
      zsh.enable = true;
    };

    neovim = {
      enable = true;

      appearance.enable = true;
      languages.enable = true;

      search.enable = true;
      utilities.enable = true;
      passive.enable = true;

      git.enable = true;
      lsp.enable = true;

      misc.enable = true;
    };
    
    dots.enable = true;
  };
  
}
