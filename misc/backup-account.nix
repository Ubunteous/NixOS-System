{ config, ... }:

# No need for a backup account if you can login as root
{
  # Define a user account
  # Do not forget to set a password with ‘passwd backup’
  users.users.backup = {
    isNormalUser = true;
    description = "backup";
    extraGroups = [ "wheel" ];
  };
}
