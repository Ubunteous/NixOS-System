{ config, pkgs, home-manager, user, ... }:

##############
#   NEOVIM   #
##############

{
  home-manager.users.${user} = {
    programs.neovim = {
      enable = true;

      viAlias = true;
      vimAlias = true;

      # programs.neovim.extraLuaConfig
        
      extraConfig = ''
        " the config can also be placed in a file
        " extraConfig = lib.fileContents ../path/to/your/init.vim;

        " set number relativenumber

        " ####################### " 
        " # colemak ijkl motion # "
        " ####################### "

        " m: record current line/position as mark / M: move middle of screen => j
        " n: repeat the search in the same direction / N: opposite => k
        " e: move to end of word / E: end  of token => m
        " i: insert mode / I: at beginning line => l

        noremap m h
        noremap n j
        noremap e k
        noremap i l
        
        noremap h n
        noremap j m
        noremap k e
        noremap l i
      '';

      plugins = with pkgs.vimPlugins; [
        nerdtree {
          plugin = nerdtree;
          config = ''
            autocmd VimEnter * NERDTree | wincmd p
            :let g:NERDTreeWinSize=15
          '';
        }

        vim-airline
        vim-airline-themes {
          plugin = vim-airline-themes;
          config = "let g:airline_theme='molokai'";
        }
        
        molokai {
          plugin = molokai;
          config = ''
            let g:molokai_original = 1
            colorscheme molokai
          '';
        }

        undotree
      ];      
    };
  };
}
