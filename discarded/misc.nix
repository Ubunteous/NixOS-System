#################
#   DIR_COLOR   #
#################

# Setup later. The next two lines are useless in config files
# eval $(dircolors -b /home/${user}/.dir_colors)
# eval $(dircolors -b /homeu/${user}/dircolors.ansi-dark)

# programs.dircolors = {
#   enable = true;
#   settings = {
#     "TERM" = "alacritty";
#     ".txt" = "01;35";
#     ".sh" = "01;35";
#     ".zsh" = "01;35";
#     "DIR" = "34";
#   };
# };

###############
#   POLYBAR   #
###############

systemd.user.services.polybar = {
  Install.WantedBy = [ "graphical-session.target" ];
};

# services.polybar = {
# enable = true;
# package = {
#   pkgs.polybar.override = {
#     i3GapsSupport = true;
#     alsaSupport = true;
#     iwSupport = true;
#     githubSupport = true;
#   };
# };

#############
#   EMACS   #
#############

# programs.emacs = {
#   enable = true;
#   extraPackages = epkgs: [ epkgs.vterm ];
# };

###########
#   GIT   #
###########

# programs.git = {
#   enable = true;
#   # };
# };
