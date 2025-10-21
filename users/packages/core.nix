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
      file-roller # file-roller
      gnome-disk-utility # gnome-disks
      keepassxc
      networkmanagerapplet
      # tlp # battery life
      eww
      rofi # history sorted by frequency in ~/.cache/rofi3.(d)runcache

      zip
      eza # ls
      bat # cat
      fd # find
      just # make
      fzf # alternative: peco
      hstr # history. see also mcfly
      tldr # man. see also navi, cheat
      ripgrep # grep. combine it with fzf later
      # httm # zfs/restic time machine
      # uutils-coreutils # rust coreutils
    ];
  };
}
