{ config, lib, pkgs, ... }:

with lib;
let cfg = config.home.neovim;
  in {
    options.home.neovim.search = {
      enable = mkEnableOption "Configure search plugins for vim";
    };

    config = mkIf (cfg.distro == "nix" && cfg.search.enable) {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      ########
      # FIND #
      ########

      # the following plugins (telescope to clap) have functionality overlap

      # with its own interface
      {
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          local builtin = require('telescope.builtin')
          -- vim.keymap.set('n', '<leader>ff', builtin.find_files, {})

          wk.register({
            ["<leader>f"] = {
                name = "telescope",
                f = { "<cmd>Telescope find_files<cr>", "Telescope Find Files" },
                c = { function() builtin.find_files({ cwd = utils.buffer_dir() }) end, "Find files in cwd"},
                g = { "<cmd>Telescope live_grep<cr>", "Telescope Live Grep" },
                b = { "<cmd>Telescope buffers<cr>", "Telescope Buffers" },
                h = { "<cmd>Telescope help_tags<cr>", "Telescope Help Tags" },
            },
          })
        '';
      }

      vim-grepper # like grep. cool but maybe redundant

      # leap-nvim # missing require('leap').create_default_mappings()

      flash-nvim

      ##################
      # GARBAGE - FIND #
      ##################

      # vim-ripgrep # not in nix
      # ctrlsf.vim # sublime like search # not in nix
      # incsearch-vim # deprecated as feature built-in vim

      # ferret # multi file search. less popular
      # skim # fzf alternative # maybe more limited
      # hop-nvim # deprecated
      # lightspeed-nvim # deprecated for leap
      # vim-sneak # 2 letters f{search}. like leap
      # vim-easymotion

      # is it even working?
      # {
      #   plugin = command-t;
      #   type = "lua";
      #   # place this config to remove useless warning
      #   config = ''
      #     require("wincent.commandt").setup()
      #   '';
      # }

    ];
  };
}
