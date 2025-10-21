{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.home.vscode;
  homecfg = config.home;
in {
  options.home.vscode = {
    enable = mkEnableOption "Enable support for the VSCode editor";
  };

  config = mkIf (homecfg.enable && cfg.enable) {
    ##############
    #   VSCODE   #
    ##############

    programs.vscode = {
      enable = true;

      # package = pkgs.vscode-fhs;

      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;

      # DISABLE THIS LATER ONCE SETTINGS IN NIX
      # do not let vscode install/updated extensions
      mutableExtensionsDir = false;

      ##############
      # EXTENSIONS #
      ##############

      extensions = with pkgs.vscode-extensions; [
        #############
        # Languages #
        #############

        # ms-dotnettools.csdevkit
        # ms-dotnettools.csharp
        # ms-dotnettools.vscode-dotnet-runtime
        # ms-vscode.powershell

        #######
        # Git #
        #######
        eamodio.gitlens
        # donjayamanne.githistory
        # github.vscode-pull-request-github
        # waderyan.gitblame
        # mhutchie.git-graph
        # github.vscode-github-actions

        ############
        # Bindings #
        ############

        # vscodevim.vim
        tuttieee.emacs-mcx

        ########
        # Misc #
        ########

        oderwat.indent-rainbow
        streetsidesoftware.code-spell-checker
      ];

      # written in settings.json
      # "[nix]"."editor.tabSize" = 2;
      # "workbench.sideBar.location" = "left"; # sidebar
      userSettings = {
        "editor.acceptSuggestionOnEnter" = "off";
        "editor.cursorStyle" = "block";
        "editor.fontFamily" = "Fira Code";
        "editor.fontLigatures" = true;
        "editor.fontSize" = 18;
        "editor.formatOnPaste" = true;
        "editor.formatOnSave" = true;
        "editor.renderWhitespace" = "trailing";

        "explorer.excludeGitIgnore" = true;
        "explorer.sortOrder" = "type";

        "files.autoSave" = "afterDelay";
        "files.trimFinalNewlines" = true;
        "files.trimTrailingWhitespace" = true;

        "workbench.panel.defaultLocation" = "right";
        "workbench.colorTheme" = "Monokai";
        "workbench.editor.centeredLayoutAutoResize" = false;
        "workbench.editor.highlightModifiedTabs" = true;
        "workbench.externalBrowser" = "firefox";

        "extensions.autoCheckUpdates" = false;
        "telemetry.telemetryLevel" = "off";
        "update.mode" = "none";
        "window.zoomLevel" = 3;
      };

      #############
      #   BINDINGS   #
      #############

      # keybindings.kb = {
      #   args = {
      #     direction = "up";
      #   }; # Optional arguments for a command. null or JSON value
      #   command =
      #     "editor.action.clipboardCopyAction"; # The VS Code command to execute. string
      #   key = "ctrl+c"; # The key or key-combination to bind. string
      #   when = "textInputFocus"; # Optional context filter
      # };

      #############
      #   SNIPPETS   #
      #############

      # globalSnippets = {
      #   fixme = {
      #     body = [ "$LINE_COMMENT FIXME: $0" ];
      #     description = "Insert a FIXME remark";
      #     prefix = [ "fixme" ];
      #   };
      # };

      # languageSnippets = {
      #   haskell = {
      #     fixme = {
      #       body = [ "$LINE_COMMENT FIXME: $0" ];
      #       description = "Insert a FIXME remark";
      #       prefix = [ "fixme" ];
      #     };
      #   };
      # };

      ###########
      #   TASKS   #
      ###########

      # # commands made with external tools (linters, formatters, build)
      # userTasks = {
      # 	version = "2.0.0";
      # 	tasks = [
      # 	  {
      # 	    type = "shell";
      # 	    label = "Hello task";
      # 	    command = "hello";
      # 	  }
      # 	];
      # };
    };
  };
}
