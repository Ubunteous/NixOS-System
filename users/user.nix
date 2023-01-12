{ config, pkgs, user, ... }:

{
  # add zsh to /etc/shells
  environment.shells = with pkgs; [ zsh ];

  # Define a user account
  # Do not forget to set a password with ‘passwd’

  users.users.${user} = {
    isNormalUser = true;
    description = "${user}";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh; # set user's default shell
  };
}
