{ pkgs, home-manager, user, ... }:

#############
#   GNUPG   #
#############

{
  home-manager.users.${user} = {
    programs.gpg.enable = true;
    
    services.gpg-agent = {
      enable = true;

      maxCacheTtl = 34560000;
      defaultCacheTtl = 34560000;
      # pinentryFlavor = "tty"; # default: gtk2

      enableSshSupport = true;
      enableExtraSocket = true;
      enableScDaemon = true;
      maxCacheTtlSsh = 34560000;
      defaultCacheTtlSsh = 34560000;
    };
    
    # restart the agent with these commands to activate changes:
    # gpgconf --kill gpg-agent
    # gpg-agent --daemon #--use-standard-socket #last part obsolete

    # use these commands to create a key and encrypt file
    # gpg --full-generate-key
    # gpg --symmetric <file>
    # gpg --decrypt <file>
  };
}
