{
  config,
  lib,
  pkgs,
  user,
  ...
}:

with lib;
let
  cfg = config.user.packages.core;
  usercfg = config.user;
in
  {
	options.user.packages.core = {
      enable = mkEnableOption "Enable essential packages";
	};

	config = mkIf (usercfg.enable && cfg.enable) {
    users.users.${user}.packages = with pkgs; [
      # httm # zfs/restic time machine
      # tlp # battery life
      # uutils-coreutils # rust coreutils
      bat # cat
      eww
      eza # ls
      fd # find
      file-roller # file-roller
      fzf # alternative: peco
      gnome-disk-utility # gnome-disks
      hstr # history. see also mcfly
      just # make
      keepassxc
      net-tools
      networkmanagerapplet
      nmap
      ripgrep # grep. combine it with fzf later
      rofi # history sorted by frequency in ~/.cache/rofi3.(d)runcache
      tealdeer # tldr
      tldr # man. see also navi, cheat
      zip
    ];
  };
}
