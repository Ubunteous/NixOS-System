{ config, lib, ... }:

with lib;
let
  cfg = config.home.terminal.ssh;
  homecfg = config.home;
in {
  options.home.terminal.ssh = {
    enable = mkEnableOption "Enable support for SSH";
  };

  config = mkIf (homecfg.enable && cfg.enable) {
    ###########
    #   SSH   #
    ###########

    programs.ssh = {
      enable = true;

      # Configure sharing of multiple sessions over a single network connection
      # re-use existing connection if possible (faster+stable)
      controlMaster = "auto";
      controlPersist = "yes";
      controlPath = "~/.ssh/control/%C"; # default: "~/.ssh/master-%r@%n:%p"
    };

    # services.ssh-agent.enable = true;
    # services.gpg-agent.enableSshSupport = true;
  };
}
