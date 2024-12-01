{ pkgs, config, home-manager, user, ... }:

##############
#   MBSYNC   #
##############

{
  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
  programs.notmuch = {
    enable = true;
    hooks = { preNew = "mbsync --all"; };

    # this config is saved in ~/.config/notmuch
    # extraConfig = {
    #   database = { path = "${config.home.homeDirectory}/mbsync"; };
    # };

  };

  accounts.email = {
    maildirBasePath = "mbsync"; # can be a path relative to $HOME

    accounts.m9 = {
      primary = true;

      address = config.services.maildata.address;
      userName = config.services.maildata.address;
      realName = config.services.maildata.name;

      msmtp.enable = true;
      notmuch.enable = true;

      # passwordCommand = "${pkgs.gnupg}/bin/gpg -q --for-your-eyes-only --no-tty --exit-on-status-write-error --batch -d ${config.home.homeDirectory}/.nix.d/home/mail/m9.gpg";

      # passwordCommand = "${pkgs.gnupg}/bin/gpg --use-agent --quiet --batch -d /home/${user}/.nix.d/home/mail/m9.gpg";
      # passwordCommand = "gpg2 -q --for-your-eyes-only --no-tty -d /home/${user}/.nix.d/home/mail/.m9.gpg";
      passwordCommand =
        "gpg2 -q --for-your-eyes-only --batch --passphrase-file ${config.home.homeDirectory}/.nix.d/home/mail/.m9.txt --no-tty -d ${config.home.homeDirectory}/.nix.d/home/mail/.m9.gpg";

      imap.host = "imap.gmail.com";
      smtp.host = "smtp.gmail.com";

      mbsync = {
        # update with mbsync -a
        enable = true;
        create = "maildir"; # none, imap, both
        expunge = "maildir";

        extraConfig.local = {
          # change paths in ~/.mbsyncrc
          Inbox = "${config.home.homeDirectory}/mbsync/Inbox";
          Path = "${config.home.homeDirectory}/mbsync/";
        };

        patterns = [
          "*"
          "![Gmail]*"
          "[Gmail]/Sent Mail"
          "[Gmail]/Starred"
          "[Gmail]/All Mail"
        ];
        extraConfig = {
          channel = { Sync = "All"; };
          account = {
            Timeout = 120;
            PipelineDepth = 1;
          };
        };
      };

      signature = {
        text = ''
          Best regards,

          ${config.services.maildata.name}
        '';
        showSignature = "append";
      };
    };
  };
}
