{ pkgs, ... }:

{
  programs.neovim = {
  enable = true;
  # defaultEditor = true;
  viAlias = true;
  configure = {
    customRC = ''
        "set undofile
        "set undodir=~/.vim/undodir

        "theme
        set termguicolors
        colorscheme NeoSolarized
        set background=dark

        :lua require('lualine').setup()
        "options = { theme = 'gruvbox' }

    '';
    packages.nix.start = with pkgs.vimPlugins; [
      vim-startify
      # vim-airline # slow
      lualine-nvim # needs lua config with extraConfig nix
      # vim-colors-solarized
      NeoSolarized

      nerdtree
      nerdcommenter

      # telescope-nvim
      # vim-surround
      # vim-fugitive
      # ale

      # nvim-treesitter
      # vim-gitgutter
      # YouCompleteMe
    ];
  };
  };
}
