# This belongs to a flake and is now useless since hyprland is now available as part as nixos

########################
#   HYPRLAND OUTSIDE   #
#     FLAKE OUTPUT     #
########################

# hyprland with home manager
# homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
#   pkgs = nixpkgs.legacyPackages.x86_64-linux;
#   modules = [
#     hyprland.homeManagerModules.default
#     {
#       wayland.windowManager.hyprland = {
#         enable = true;
#         # xwayland.enable = false;
#       };
#     }
#   ];
# };


######################
#   HYPRLAND INPUT   #
######################

# hyprland = {
#   url = "github:hyprwm/Hyprland";
#   # build with your own instance of nixpkgs
#   inputs.nixpkgs.follows = "nixpkgs-unstable";
# };

#######################
#   HYPRLAND OUTPUT   #
#######################

# hyprland.nixosModules.default
# { programs.hyprland.enable = true; }
