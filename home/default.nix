{ user, ... }:

{
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  home-manager.users.${user}.home = {
    stateVersion = "23.11";
    sessionVariables = {
      EDITOR = "emacs";
      BROWSER = "firefox";
      TERMINAL = "alacritty";
    };
  };

  imports = [
    ./u-he.nix
    # ./game.nix # planescape

    # conflict with .mozilla/firefox/default/search.json.mozlz4
    ./firefox.nix
    ./mime.nix # another app is creating mimes => fixed with force
    ./dunst.nix
    ./picom.nix
    ./flameshot.nix
    ./themes.nix
    ./git.nix
    
    ./terminal/zsh.nix
    ./terminal/fish.nix
    ./terminal/kitty.nix
    ./terminal/alacritty.nix
    # ./terminal/bash.nix      
    ./neovim.nix

    ./xautolock.nix # replace it with a service
    # ./xidlehook.nix # does not seem to start
    
    # for OB-xD synth
    # ./xdg-user-dir.nix
    
    # Unstable: "https://github.com/nix-community/home-manager/archive/master.tar.gz";
    # Troubleshoot: systemctl status "home-manager-$USER.service"
    # Hint: Home manager hates when a config file already exists
    # For unsupported apps: home.file."path/to/file".source = ./a/dotfile/repo/file;
  ];
}
