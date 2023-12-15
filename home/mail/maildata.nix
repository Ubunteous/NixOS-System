{ lib, pkgs, config, ... }:

################
#   MAILDATA   #
################

with lib;                      
let
  cfg = config.services.maildata;
in {
  options.services.maildata = {
    enable = true;
    # enable = mkEnableOption "maildata service";

    address = mkOption {
      type = types.str;
      default = "";
    };

    name = mkOption {
      type = types.str;
      default = "";
    };
  };
}

  # use this with a file looking like this
  # { pkgs, config, home-manager, user, ... }:

  #   ################
  #   #   MAILDATA   #
  #   ################

  #   {  
  #     config.services.maildata.address = "address@host.com";
  #     config.services.maildata.name = "Name";
  #   }
  
