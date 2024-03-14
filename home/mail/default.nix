{ lib, ... }:

with lib; {
  options.home.mail.enable = mkEnableOption "Enable support for mail";

  imports = [
    ./thunderbird.nix

    # ./gnupg.nix

    # ./maildata-home
    # ./maildata

    # ./mu-imap.nix
    # ./nm-mbsync.nix
  ];
}
