{ pkgs, ... }:

{
  programs.nix-ld =
    {
      enable = true;
      
      # package = pkgs.nix-ld; 

      # libs automatically available to all programs (default common libs)
      # programs.nix-ld.libraries = [];

    };
}
