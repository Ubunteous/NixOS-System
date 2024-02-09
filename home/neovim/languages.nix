{ config, lib, pkgs, home-manager, user, ... }:

with lib;
let
  cfg = config.home.neovim.languages;
  homecfg = config.home;
in
{
  options.home.neovim.languages = {
    enable = mkEnableOption "Configure languages plugins for vim";
  };

  config = mkIf (homecfg.enable && cfg.enable) {
    home-manager.users.${user} = {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        ##########
        # SYNTAX #
        ##########

        # python
        # needs pylama for linting
        {
          plugin = python-mode;
          config = ''
            let g:pymode_lint = 0

            " open splits vertically
            autocmd BufEnter __run__,__doc__ :wincmd L

            " remove ugly vertical bar
            " let g:pymode_options_colorcolumn = 0
            let g:pymode_options_colorcolumn = 0

            let g:pymode_run_bind = '<leader>p' " default is r
          '';
        }

        # nix
        vim-nix
      ];
    };
  };
}
