{ config, lib, user, ... }:

with lib;
let
  cfg = config.lab.ssh;
  corecfg = config.lab;
in {

  options.lab.ssh = { enable = mkEnableOption "Enables support for ssh"; };

  config = mkIf (corecfg.enable && cfg.enable) {
    services.openssh = { # note: alias openssh=sshd
      enable = true;

      # startWhenNeeded = true;

      # ports = [ "22" ];
      openFirewall = true;

      # hostKeys = [
      #   {
      #     bits = 4096;
      #     openSSHFormat = true;
      #     path = "/etc/ssh/ssh_host_rsa_key";
      #     rounds = 100;
      #     type = "rsa";
      #   }
      #   {
      #     comment = "key comment";
      #     path = "/etc/ssh/ssh_host_ed25519_key";
      #     rounds = 100;
      #     type = "ed25519";
      #   }
      # ];

      # authorizedKeysFiles = [ "" ];

      # moduliFile = "/etc/ssh/moduli";
      # extraConfig = '' '';
      # banner = "Nix banner shown before auth allowed";

      # authorizedKeysCommandUser = "nobody";
      # authorizedKeysCommand = "none";

      # listenAddresses."addr" = {
      #   port = "";
      #   addr = "";
      # };

      # knownHosts."test" = {
      #   # publicKeyFile = "/path/to/file"
      #   # publicKey = "ecdsa-sha2-nistp521 AAAAE2VjZHN...UEPg==";

      #   # hostNames = [ "‹name›" ] ++ config.services.openssh.knownHosts.<name>.extraHostNames;
      #   # extraHostNames = []; list ignored if hostNames is set

      #   # certAuthority = false;
      # };

      # # SFTP is a subsystem in SSH daemon
      # allowSFTP = true; # defaults to true
      # sftpServerExecutable = "internal-sftp";
      # sftpFlags = [ "-f AUTHPRIV" "-l INFO" ];

      settings = {
        # yes, no, without-password, prohibit-password, forced-commands-only
        PermitRootLogin = "prohibit-password";
        PasswordAuthentication = false;
        AllowUsers = [ "${user}" ];

        # X11Forwarding = false; # defaults to false
        # UseDns = false; # defaults to false
        # StrictModes = true; # defaults to true
        # Macs = [ "hmac-sha2-512-etm@openssh.com" ];

        # KbdInteractiveAuthentication = true; # defaults to true
        # GatewayPorts = "no"; # defaults to "no"
        # DenyUsers / DenyGroups / Ciphers

        # AllowGroups = [ "" ];
        # AuthorizedPrincipalsFile = "none"; # file for auth users

        # alt: "QUIET", "FATAL", "ERROR", "INFO", "VERBOSE", "DEBUG", "DEBUG1", "DEBUG2", "DEBUG3"
        # LogLevel = "INFO"; # defaults to info among
        # KexAlgorithms = [ "curve25519-sha256" ]; ;; allowed algos
      };
    };
  };
}
