{ config, lib, pkgs, ... }:

with lib;
let cfg = config.home.neovim;
  in {
    options.home.neovim.languages = {
      enable = mkEnableOption "Configure languages plugins for vim";
    };

    config = mkIf (cfg.distro == "nix" && cfg.languages.enable) {
      programs.neovim.plugins = with pkgs.vimPlugins; [
      ##########
      # SYNTAX #
      ##########

      # python
      # needs pylama for linting
      {
        plugin = python-mode;
        type = "lua";
        config = ''
          vim.g.pymode_lint = 0

          -- open splits vertically
          -- autocmd BufEnter __run__,__doc__ :wincmd L

          vim.api.nvim_create_autocmd("BufEnter", { pattern = { "__run__", "__doc__" }, command = "wincmd L" })

          -- remove ugly vertical bar
          vim.g.pymode_options_colorcolumn = 0

          vim.g.pymode_run_bind = "<leader>p" -- default is r

          -- -- if you want to use overlay feature
          -- vim.g.choosewin_overlay_enable = 1
        '';
      }

      # nix
      vim-nix
    ];
  };
}
