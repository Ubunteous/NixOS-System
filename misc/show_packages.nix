{ config, lib, pkgs, ... }:

# print package list in /etc
# Note: list packages installed (but not necessarily used by the system)

{
  environment.etc."current-system-packages".text =
    let
      packages = builtins.map (p: "${p.name}")
      config.environment.systemPackages;

      sortedUnique = builtins.sort builtins.lessThan (lib.unique packages);

      formatted = builtins.concatStringsSep "\n"
      sortedUnique;

      in

      formatted;
}
