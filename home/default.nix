{ ... }:

{    
  imports = [
    ../home/u-he.nix
    # ../home/game.nix # planescape

    # conflict with .mozilla/firefox/default/search.json.mozlz4
    ../home/firefox.nix
    ../home/mime.nix # another app is creating mimes => fixed with force
    ../home/dunst.nix
    ../home/picom.nix
    ../home/flameshot.nix
    ../home/themes.nix
    ../home/git.nix
    
    ../home/terminal/zsh.nix
    ../home/terminal/fish.nix
    ../home/terminal/kitty.nix
    ../home/terminal/alacritty.nix
    # ../home/terminal/bash.nix      
    ../home/neovim.nix

    ../home/xautolock.nix # replace it with a service
    # ../home/xidlehook.nix # does not seem to start
    
    # for OB-xD synth
    # ../home/xdg-user-dir.nix
    
    # Unstable: "https://github.com/nix-community/home-manager/archive/master.tar.gz";
    # Troubleshoot: systemctl status "home-manager-$USER.service"
    # Hint: Home manager hates when a config file already exists
    # For unsupported apps: home.file."path/to/file".source = ./a/dotfile/repo/file;
  ];
}
