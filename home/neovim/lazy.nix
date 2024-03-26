{ config, lib, pkgs, ... }:

with lib;
let cfg = config.home.neovim;
in {
  config = mkIf (cfg.enable && cfg.distro == "lazy") {
    programs.neovim = {
      enable = true;

      plugins = with pkgs.vimPlugins; [ lazy-nvim ];

      extraLuaConfig = let
        plugins = with pkgs.vimPlugins; [
          gruvbox-nvim

          which-key-nvim
          nvim-autopairs
          python-mode
          vim-fugitive

          telescope-nvim
          nvim-treesitter
          plenary-nvim # telescope dependency

          # leap-nvim ("ggandor/leap.nvim")

          # deoplete-nvim

          # appearance?
          # oil-nvim
          # alpha-nvim
          # barbar-nvim
          # lualine-nvim
          # nvim-web-devicons
          # monokai-pro-nvim
        ];

        mkEntryFromDrv = drv:
          if lib.isDerivation drv then {
            name = "${lib.getName drv}";
            path = drv;
          } else
            drv;
        lazyPath =
          pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv plugins);
      in ''
        -- Example using a list of specs with the default options
        vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
        vim.g.maplocalleader = "," -- Same for `maplocalleader`

        require("lazy").setup({
          defaults = {
            lazy = true,
          },
          dev = {
            -- reuse files from pkgs.vimPlugins.*
            path = "${lazyPath}",
            patterns = { "." },
            -- fallback to download
            fallback = false,
          },
          install = {
              -- install missing plugins on startup
              missing = false,
          },
          spec = {
            -- to import, make a lua/plugins dir and wrap specs in a return{ ... } clause

            { import = "plugins" },
          },
        })
      '';
    };

    # Normal Neovim config here
    xdg.configFile."nvim/lua/plugins".source = ./Lua/plugins;
  };
}
