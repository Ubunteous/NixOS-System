{ pkgs, home-manager, user, ... }:

###########
#   ZSH   #
###########

{
  home-manager.users.${user} = {
    programs.zsh = {
      enable = true;
      autocd = true;

      # Same history for zsh and fish?
      # Example:
      # history.path = "${config.xdg.dataHome}/zsh/zsh_history";

      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      
      shellAliases = {
        sticky = "xkbset exp -bell -sticky -twokey -latchlock -accessx -feedback -stickybeep -led 9999 && xkbset bell sticky -twokey -latchlock feedback led stickybeep";

        polybar = "/home/${user}/.config/polybar/launch.sh";
        powermenu = "/home/${user}/.config/rofi/powermenu.sh";
        gem-lock = "brightnessctl -s set 5 && i3lock -ueni ~/Pictures/gem_full.png; brightnessctl -r";
      };
      
      initExtra = ''
            zstyle ':completion:*' list-colors /home/${user}/dircolors.ansi-dark

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
          file = "share/zsh-history-substring-search/zsh-history-substring-search.zsh";
        }
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        # {
        #   name = "powerlevel10k-config";
        #   src = ../.config/p10k;
        #   file = "p10k.zsh";
        # }
      ];
    };
  };
}
