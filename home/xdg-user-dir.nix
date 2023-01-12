{ home-manager, user, ... }:

# Still experimental. Will be tested later.

###########
#   XDG   #
###########

{
  home-manager.users.${user} = {
    xdg.userDirs.enable = true;   
  };
}
