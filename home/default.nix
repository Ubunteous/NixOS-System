{ lib, ... }:

with lib; {
  options.home = { enable = mkEnableOption "Home manager configuration"; };

  # Unstable: "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  # Troubleshoot: systemctl status "home-manager-$USER.service"
  # Hint: Home manager hates when a config file already exists
  # For unsupported apps: home.file."path/to/file".source = ./a/dotfile/repo/file;

  config.home = {
    stateVersion = "23.11";
    sessionVariables = {
      EDITOR = "emacs";
      BROWSER = "firefox";
      TERMINAL = "wezterm";
    };
  };

  imports = [
    # conflict with .mozilla/firefox/default/search.json.mozlz4
    ./firefox.nix
    ./flameshot.nix
    ./dunst.nix
    ./git.nix
    ./mime.nix # another app is creating mimes => fixed with force
    ./picom.nix
    ./redshift.nix
    ./themes.nix
    ./u-he.nix
    ./vscode.nix
    ./xautolock.nix # replace it with a service
    ./godot.nix
    # ./helix.nix

    # ./kodi.nix

    ./mail
    ./neovim
    ./terminal
    ./emacs.nix
    ./nix-direnv.nix
    ./xdg-user-dir.nix # for OB-xD synth

    # ./eww.nix
    ./dots.nix
  ];
}
