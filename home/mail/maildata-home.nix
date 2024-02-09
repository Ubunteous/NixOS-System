{ pkgs, config, home-manager, user, ... }:

################
#   MAILDATA   #
################

{  
  config.services.maildata.address = "mail@domain.com";
  config.services.maildata.name = "Name Surname";
}

