{ ... }:

# lib.mkIf (config.networking.hostName == "") { imports = [ ../core/lightdm.nix ]; }

{    
  
  imports = [
    ./boot.nix
    ./networking.nix

    # ./display-managers/sddm.nix
    # ./display-managers/gdm.nix
    ./display-managers/lightdm.nix

    ./sound.nix
    ./file-systems.nix
    ./system-packages.nix
    # ./neovim.nix
    ./kanata.nix
    # ./autorandr.nix # does not work (9/23)
    ./nix-ld.nix
  ];
}

