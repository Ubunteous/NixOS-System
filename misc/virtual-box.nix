{ ... }:

{
  ##################
  #   Virtualbox   #
  ##################

  # NOTE: restart after adding to group (vboxusers)
  
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "ubunteous" "sudo" ];
  virtualisation.virtualbox.host.enableExtensionPack = true;
  # nixpkgs.config.allowBroken = true;
  # virtualisation.virtualbox.guest.enable = true; # broken
  # virtualisation.virtualbox.guest.x11 = true;
} 
