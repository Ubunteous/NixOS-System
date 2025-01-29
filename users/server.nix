{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.user.server;
  usercfg = config.user;
in {
  options.user.server = { enable = mkEnableOption "Add nix user"; };

  config = mkIf (usercfg.enable && cfg.enable) {
    # add zsh to /etc/shells
    environment.shells = with pkgs; [ zsh ];

    # potential fix starting from update to 23.05
    programs.zsh.enable = true;

    users.groups.${user} = {};

    users.users.${user} = {
      isNormalUser = true;
      description = "${user}";
      group = "${user}"; # for safety as nogroup is not ideal 

      extraGroups = [ "networkmanager" "wheel" "uinput" ];

      shell = pkgs.zsh; # set user's default shell
    };
  };
}
