{ home-manager, user, ... }:

# Unstable: "https://github.com/nix-community/home-manager/archive/master.tar.gz";
# Troubleshoot: systemctl status "home-manager-$USER.service"
# Hint: Home manager hates when a config file already exists
# For unsupported apps: home.file."path/to/file".source = ./a/dotfile/repo/file;

{
  ####################
  #   HOME MANAGER   #
  ####################

  # Unstable: "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  # Troubleshoot: systemctl status "home-manager-$USER.service"
  # Hint: Home manager hates when a config file already exists
  # For unsupported apps: home.file."path/to/file".source = ./a/dotfile/repo/file;

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  programs.dconf.enable = true; # for themes and more

  home-manager.users.${user}.home.sessionVariables = {
    EDITOR = "emacs";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };
}
