{ pkgs, config, home-manager, user, ... }:

###################
#   OFFLINEIMAP   #
###################

{  
  home-manager.users.${user} = {

    programs.mu.enable = true;
    
    programs.offlineimap = {
      enable = true;

      extraConfig.general = {
        accounts = "m9";
        maxsyncaccounts = 1; 
      };
      
      pythonFile = ''
          from pathlib import Path
          import subprocess

          def mailpasswd(account):
              path = Path(f"/home/ubunteous/.nix.d/home/mail/{account}.gpg")
              # args = ["gpg", "--use-agent", "--quiet", "--batch", "-d", path]
              args = ["gpg2", "-q", "--for-your-eyes-only", "--batch", "--passphrase-file", "/home/${user}/.nix.d/home/mail/.m9.txt","--no-tty", "-d", "/home/${user}/.nix.d/home/mail/.m9.gpg"]
              try:
                  return subprocess.check_output(args).strip()
              except subprocess.CalledProcessError:
                  return ""
          '';
    };

    accounts.email = {
      accounts.m9 = {
        primary = true; # it is essential to have one primary mail
        
        address = config.services.maildata.address;
        userName = config.services.maildata.address;
        realName = config.services.maildata.name;

        imap.host = "imap.gmail.com";
        smtp.host = "smtp.gmail.com";

        mu.enable = true;
        
        # this does not install offlineimap but just enables it for this email address
        offlineimap = {
          enable = true;
          postSyncHookCommand = "mu index";
          
          extraConfig.account = {
            # NixOS names local/remote to <name>-local and <name>-remote
            # localrepository = "local";
            # remoterepository = "remote";
            maxage = 365;
          };
          
          extraConfig.local = {
            type = "Maildir";
            localfolders = "~/Maildir";
          };
          
          extraConfig.remote = {
            type = "IMAP";
            remotehost = "imap.gmail.com";
            remoteuser = config.services.maildata.address;
            ssl = "yes";
            sslcacertfile = "/etc/ssl/certs/ca-certificates.crt";
            maxconnections = 1;

            # add this line for each remote repository
            # uses the python function to decipher the passfile
            remotepasseval = "mailpasswd('m9')";
          };
        };
      };
    };
  };
}
