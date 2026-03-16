{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.user.packages.core;
  usercfg = config.user;
in {
  options.user.packages.core = {
    enable = mkEnableOption "Enable essential packages";
  };

  config = mkIf (usercfg.enable && cfg.enable) {
    users.users.${user}.packages = with pkgs; [
      eww
      file-roller # file-roller
      gnome-disk-utility # gnome-disks
      keepassxc
      networkmanagerapplet
      rofi # history sorted by frequency in ~/.cache/rofi3.(d)runcache
      # tlp # battery life

      bat # cat
      eza # ls
      fd # find
      fzf # alternative: peco
      hstr # history. see also mcfly
      # httm # zfs/restic time machine
      just # make
      ripgrep # grep. combine it with fzf later
      tldr # man. see also navi, cheat
      # uutils-coreutils # rust coreutils
      zip
    ];
  };
}
