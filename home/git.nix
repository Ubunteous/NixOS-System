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
      # try another mail provided by git
      settings.user = {
        name = "Ubunteous";
        email = "46612154+Ubunteous@users.noreply.github.com";

        ############
        # COMMANDS #
        ############

        # See all options with man git-config
        # also check https://jvns.ca/blog/2024/02/16/popular-git-config-options/

        init.defaultBranch = "master";

        diff = {
          renames = true;
          mnemonicPrefix = true;
          colorMoved = "plain";
          algorithm = "histogram";

          # context = 10;
          # colorMoved = "default";
          # tool = "difftastic"; # external package
        };

        push = {
          followTags = true;
          default = "simple";
          autoSetupRemote = true;
        };

        pull = {
          # use either
          ff = "only";
          # rebase = true;
        };

        fetch = {
          all = true;

          # removes local copies if not on remote. risky
          # pruneTags = true;
          # prune = true;
        };

        rebase = {
          updateRefs = true;
          autoSquash = true;
          # autoStash = true; # risky. potential merge

          # prevents commit deletion in rebase
          missingCommitsCheck = "error";
        };

        merge = {
          conflictstyle = "zdiff3";
          # tool = "meld"; # external package
        };

        ########
        # MISC #
        ########

        help.autocorrect = "prompt"; # or 10 to change next second
        commit.verbose = true;

        rerere = {
          enabled = true;
          autoupdate = true;
        };

        core = {
          editor = "emacs";
          # excludesfile = "~/.gitignore";
          # pager = "delta"; # external package
        };

        column.ui = "auto";

        ########
        # SORT #
        ########		

        branch.sort = "-committerdate";
        tag.sort = "version:refname"; # or "taggerdate"

        ##############
        # SUBMODULES #
        ##############

        diff.submodule = "log";
        submodule.recurse = true;
        status.submoduleSummary = true;

        ########################
        # CORRUPTION DETECTION #
        ########################

        transfer.fsckobjects = "true";
        fetch.fsckobjects = "true";
        receive.fsckObjects = "true";

        ############
        # COMMENTS #
        ############

        # useful to have a different config at work (with different mail for instance)
        # [includeIf "gitdir:~/code/<work>/"]
        # path = "~/code/<work>/.gitconfig"
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
