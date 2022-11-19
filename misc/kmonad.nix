# ** flake

# kmonad.url = "github:kmonad/kmonad?dir=nix";
# outputs = inputs @ { self, ..., kmonad }:

# ** Packages (system)
  
##############
#   KMONAD   #
##############

# kmonad

# extraGroups = [ "input" "uinput"];

# **services

##############
#   KMONAD   #
##############

# imports = [
#   ./kmonad-module.nix
# ];

# services.kmonad = {
# enable = false; # disable to not run kmonad at startup
# configfiles = [ ~/.config/kmonad/kmonad.kbd ];
# };

# new group for kmonad
# users.groups = { uinput = {}; };

# new rules for kmonad
# services.udev.extraRules =
# ''
#   # KMonad user access to /dev/uinput
#   KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
# '';
