{
  # update a specific input in the flake lock
  # nix flake lock --update-input nixpkgs --update-input nix

  description = "A flake for building my NixOS configuration";

  # To avoid rebuilding inputs on nixos-rebuild test/switch, use
  # sudo nixos-rebuild build --flake '.nix.d/#' beforehand

  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    musnix.url = "github:musnix/musnix";
    nur.url = "github:nix-community/NUR";

    # stylix.url = "github:danth/stylix";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";

      # stable release, may not work
      # url = "github:nix-community/home-manager/release-23.05";
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-index-database = {
    #   url = "github:Mic92/nix-index-database";
    #   inputs.nixpkgs.follows = "nixpkgs-unstable";
    # };

    # divide flakes in modules
    # flake-parts.url = "github:hercules-ci/flake-parts";

    # seen in nix-direnv flake demo. Is it useful?
    # flake-utils.url = "github:numtide/flake-utils";

    # agenix = {
    #   url = "github:ryantm/agenix";

    #   # do not download darwin deps to save resources on Linux
    #   inputs.darwin.follows = "";
    #   inputs.home-manager.follows = "";
    #   # inputs.nixpkgs.follows = "";
    # };

    # proxmox-nixos.url = "github:SaumonNet/proxmox-nixos";
  };

  outputs = { ... }@args: import ./outputs.nix args;
  # outputs = { self, nixpkgs-stable, nixpkgs-unstable, nixos-hardware, home-manager, nur, musnix }:
}
