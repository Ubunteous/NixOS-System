{ config, pkgs, user, ... }:

{
  # add zsh to /etc/shells
  environment.shells = with pkgs; [ zsh ];

  # potential fix starting from update to 23.05
  programs.zsh.enable = true;

  users.groups = { uinput = {}; }; # for KMonad
  
  # Define a user account
  # Do not forget to set a password with ‘passwd’

  users.users.${user} = {
    isNormalUser = true;
    description = "${user}";

    # realtime audio for musnix
    # uinput and input for kmonad and kanata
    extraGroups = [ "networkmanager" "wheel" "realtime" "audio" "uinput" ];

    shell = pkgs.zsh; # set user's default shell
  };
}
