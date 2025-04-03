{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.home.terminal.zsh;
  homecfg = config.home;
in {
  options.home.terminal.zsh = {
    enable = mkEnableOption "Enable support for Zsh";
  };

  config = mkIf (homecfg.enable && cfg.enable) {
    ###########
    #   ZSH   #
    ###########

    programs.zsh = {
      enable = true;
      autocd = true;

      # dirHashes = {
      # 	docs  = "$HOME/Documents";
      # 	vids  = "$HOME/Videos";
      # 	dl    = "$HOME/Downloads";
      # 	org = "$HOME/org";
      # };

      # Same history for zsh and fish?
      # Example:
      # history.path = "${config.xdg.dataHome}/zsh/zsh_history";

      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        sticky =
          "xkbset exp -bell -sticky -twokey -latchlock -accessx -feedback -stickybeep -led 9999 && xkbset bell sticky -twokey -latchlock feedback led stickybeep";

        powermenu = "${config.home.homeDirectory}/.config/rofi/powermenu.sh";
        gem-lock =
          "brightnessctl -s set 5 && i3lock -ueni ~/Pictures/gem_full.png; brightnessctl -r";

        # ls = ''eza --hide="*~"'';
        ls = ''eza --ignore-glob="*~"'';
        cat = "bat";
        ni = "janet ~/.nix.d/bin/ni.janet";

        # safety.
        # rm = "rm -I"; # or -i
      };

      initExtra = ''
        # export necessary for yabridgectl
                # export WINEFSYNC=1
                # export PATH=$PATH:/etc/profiles/per-user/ubunteous/lib

                # case insensitive completion
        autoload -Uz compinit && compinit
          zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
        	
            # dircolrs.ansi-dark unavailable. maybe add later with nix
            # zstyle ':completion:*' list-colors ${config.home.homeDirectory}/dircolors.ansi-dark

            bindkey '^r' history-substring-search-up
              bindkey '^s' history-substring-search-down
              bindkey '^ ' autosuggest-accept # ctrl+space

              #########################
              #  Options for fzf-tab  #
              #########################

              # set descriptions format to enable group support
              zstyle ':completion:*:descriptions' format '[%d]'

              # make use of fzf-preview option
              zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath' # remember to use single quote here!!!

                # preview directory's content with exa when completing cd
                zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'

                  # switch group using `,` and `.`
                  zstyle ':fzf-tab:*' switch-group ',' '.'

                # complete with :
                zstyle ':fzf-tab:*' continuous-trigger ':'

                  # accept and keep searching
                  zstyle ':fzf-tab:*' fzf-bindings 'space:accept'

                  # accept and run
                  zstyle ':fzf-tab:*' accept-line tab

                  #######################
                  #   POWER LEVEL 10K   #
                  #######################

                  source ~/.config/p10k/p10k.zsh
      '';

      plugins = [
        # find info for the file field of zsh plugins:
        # cd /nix/store && find *plugin name*
        {
          # load fzf-tab before zsh-autosuggestions/syntax-highlighting
          name = "fzf-tab";
          src = pkgs.zsh-fzf-tab;
          file = "share/fzf-tab/fzf-tab.plugin.zsh";
        }
        # {
        #   # too slow
        #   name = "autocomplete";
        #   src = pkgs.zsh-autocomplete;
        #   file = "share/zsh-autocomplete/zsh-autocomplete.plugin.zsh";
        # }

        {
          # load syntax-highlighting before history substring search
          name = "syntax-highlighting";
          src = pkgs.zsh-syntax-highlighting;
          file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
        }
        {
          name = "autosuggestions";
          src = pkgs.zsh-autosuggestions;
          file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
        }
        {
          name = "completions";
          src = pkgs.zsh-completions;
        }
        {
          name = "history-substring-search";
          src = pkgs.zsh-history-substring-search;
          file =
            "share/zsh-history-substring-search/zsh-history-substring-search.zsh";
        }
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }

        # # keep using zsh with nix-shell
        # {
        #   name = "zsh-nix-shell";
        #   file = "nix-shell.plugin.zsh";
        #   src = pkgs.fetchFromGitHub {
        #     owner = "chisui";
        #     repo = "zsh-nix-shell";
        #     rev = "v0.8.0";
        #     sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        #   };
        # }

        # {
        #   name = "powerlevel10k-config";
        #   src = ../.config/p10k;
        #   file = "p10k.zsh";
        # }
      ];
    };
  };
}
