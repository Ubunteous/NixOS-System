{ pkgs, home-manager, user, ... }:

###########
#   GIT   #
###########

{
  home-manager.users.${user} = {
    programs.git = {
      enable = true;
      userName  = "Ubunteous";
      # try another mail provided by git
      userEmail = "46612154+Ubunteous@users.noreply.github.com";
      # extraConfig = {
      #   core = {
      #     askPass = false;
      #   };
      # };
    };
  };
}
