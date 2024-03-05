{ config, pkgs, ... }:

let
  unstable = import
    (builtins.fetchTarball https://github.com/nixos/nixpkgs/tarball/master)
    # reuse the current configuration
    { config = config.nixpkgs.config; };
in
{
  # nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Note use flakes to get unstable packages declaratively
  # https://channels.nixos.org/
  # sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable unstable
  # sudo nix-channel --list
  # sudo nix-channel --update
  

  #####################
  #   SLICK GREETER   #
  #####################

  environment.systemPackages = with pkgs; [
    unstable.lightdm-slick-greeter
  ];

  #  services.xserver.displayManager.lightdm.greeters.slick.enable = true;
  # services.xserver.displayManager.lightdm.greeters.slick.theme.package = pkgs.gnome.gnome-themes-extra;
  # services.xserver.displayManager.lightdm.greeters.slick.theme.name = "Adwaita";
  # services.xserver.displayManager.lightdm.greeters.slick.font.package = pkgs.ubuntu_font_family;
  # services.xserver.displayManager.lightdm.greeters.slick.font.name = "Ubuntu 11";
  # services.xserver.displayManager.lightdm.greeters.slick.extraConfig = "";
  # services.xserver.displayManager.lightdm.greeters.slick.iconTheme.package = "pkgs.gnome.adwaita-icon-theme";
  # services.xserver.displayManager.lightdm.greeters.slick.iconTheme.name = "Adwaita";
  # services.xserver.displayManager.lightdm.greeters.slick.draw-user-backgrounds = true;
}
