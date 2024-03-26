{ config, lib, pkgs, ... }:

with lib;
let cfg = config.home.neovim;
  in {
    config = mkIf (cfg.enable && cfg.distro == "Lazy") {
      # config made following:
      # https://github.com/LazyVim/LazyVim/discussions/1972

      programs.neovim = {
	enable = true;

	# extraPackages = with pkgs;
	# [
	# # LazyVim
	# lua-language-server
	# stylua
	# # Telescope
	# ripgrep
	# ];

	plugins = with pkgs.vimPlugins; [ lazy-nvim ];

	extraLuaConfig = let
        plugins = with pkgs.vimPlugins;
          [
            LazyVim # distro based on lazy-nvim

            bufferline-nvim
            cmp-buffer
            cmp-nvim-lsp
            cmp-path
            cmp_luasnip
            conform-nvim
            dashboard-nvim
            dressing-nvim
            flash-nvim
            friendly-snippets
            gitsigns-nvim
            indent-blankline-nvim
            lualine-nvim
            neo-tree-nvim
            neoconf-nvim
            neodev-nvim
            noice-nvim
            nui-nvim
            nvim-cmp
            nvim-lint
            nvim-lspconfig
            nvim-notify
            nvim-spectre
            nvim-treesitter
            nvim-treesitter-context
            nvim-treesitter-textobjects
            nvim-ts-autotag
            nvim-ts-context-commentstring
            nvim-web-devicons
            persistence-nvim
            plenary-nvim
            telescope-fzf-native-nvim
            telescope-nvim
            todo-comments-nvim
            tokyonight-nvim
            trouble-nvim
            vim-illuminate
            vim-startuptime
            which-key-nvim
            {
              name = "LuaSnip";
              path = luasnip;
            }
            {
              name = "catppuccin";
              path = catppuccin-nvim;
            }
            {
              name = "mini.ai";
              path = mini-nvim;
            }
            {
              name = "mini.bufremove";
              path = mini-nvim;
            }
            {
              name = "mini.comment";
              path = mini-nvim;
            }
            {
              name = "mini.indentscope";
              path = mini-nvim;
            }
            {
              name = "mini.pairs";
              path = mini-nvim;
            }
            {
              name = "mini.surround";
              path = mini-nvim;
            }
          ] ++ [ gruvbox-nvim ];
        mkEntryFromDrv = drv:
          if lib.isDerivation drv then {
            name = "${lib.getName drv}";
            path = drv;
          } else
            drv;
        lazyPath =
          pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv plugins);
      in ''
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
              -- install missing plugins on startup. This doesn't increase startup time.
              missing = false,
          },
          spec = {
            { "LazyVim/LazyVim", import = "lazyvim.plugins" },

            -- The following configs are needed for fixing lazyvim on nix
            -- force enable telescope-fzf-native.nvim
            { "nvim-telescope/telescope-fzf-native.nvim", enabled = true },

            -- disable mason.nvim, use programs.neovim.extraPackages
            { "williamboman/mason-lspconfig.nvim", enabled = false },
            { "williamboman/mason.nvim", enabled = false },

            -- import/override with your own plugins
            -- if you do not setup any of your plugins for LazyVim, comment this line
            -- otherwise,you will get a "No specs found for module plugins" error
            { import = "plugins" },

            -- treesitter handled by xdg.configFile."nvim/parser", put this line at the end of spec to clear ensure_installed
            { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = {} } },
          },
        })
      '';
    };

    # https://github.com/nvim-treesitter/nvim-treesitter#i-get-query-error-invalid-node-type-at-position
    # xdg.configFile."nvim/parser".source = let
    #   parsers = pkgs.symlinkJoin {
    #     name = "treesitter-parsers";
    #     paths = (pkgs.vimPlugins.nvim-treesitter.withPlugins
    #       (plugins: with plugins; [ c lua ])).dependencies;
    #   };
    #   in "${parsers}/parser";

    # Normal LazyVim config here, see https://github.com/LazyVim/starter/tree/main/lua
    # xdg.configFile."nvim/lua".source = ./Lazy;
    xdg.configFile."nvim/lua/plugins".source = ./Lazy/plugins;
  };
}
