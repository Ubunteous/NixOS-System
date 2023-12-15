{ config, pkgs, user, ... }:

{
  users.users.${user} = {
    packages = with pkgs; [
      nil
    ];
  };
}
