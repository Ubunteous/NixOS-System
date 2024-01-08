{ ... }:

{    
  imports = [
    ../core/boot.nix
    ../core/networking.nix
    # ../core/sddm.nix
    # ../core/gdm.nix
    ../core/lightdm.nix
    ../core/sound.nix
    ../core/file-systems.nix
    ../core/system-packages.nix
    # ../core/neovim.nix
    ../core/kanata.nix
    # ../core/autorandr.nix # does not work (9/23)
    ../core/nix-ld.nix
  ];
}

