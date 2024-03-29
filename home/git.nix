{ config, lib, ... }:

with lib;
let
  cfg = config.home.git;
  homecfg = config.home;
in {
  options.home.git = { enable = mkEnableOption "Enable support for Git"; };

  config = mkIf (homecfg.enable && cfg.enable) {
    ###########
    #   GIT   #
    ###########

    programs.git = {
      enable = true;
      userName = "Ubunteous";
      # try another mail provided by git
      userEmail = "46612154+Ubunteous@users.noreply.github.com";

      # See all options with man git-config
      # also check https://jvns.ca/blog/2024/02/16/popular-git-config-options/
      extraConfig = {
        push.autosetupremote = "true";
        merge.conflictstyle = "diff3"; # alt: zdiff3

        # data corruption detection
        transfer.fsckobjects = "true";
        fetch.fsckobjects = "true";
        receive.fsckObjects = "true";

        ###############
        #   OPTIONS   #
        ###############

        # init.defaultBranch master
        # Either pull.rebase true or pull.ff only

        # push.default current

        # rebase.autosquash true
        # rebase.autostash true # risky

        # commit.verbose true
        # help.autocorrect 10
        # rerere.enabled true
        # url."git@github.com:".insteadOf 'https://github.com/'

        # diff.tool difftastic
        # diff.algorithm histogram

        # sort branch/tag by date rather than name
        # branch.sort -committerdate
        # tag.sort taggerdate

        # core.pager delta
        # core.editor emacs # to edit commit messages
      };

      # hooks = { };

      ignores = [ "*~" "*#" ];
    };

    # programs.gh.enable = true;
    # programs.lazygit = {
    #   enable = true;
    #   settings = { };
    # };

    # eza git

    # programs.gitui = {
    #   enable = true;
    #   theme = "";
    #   keyConfig = "";
    # };

  };
}
