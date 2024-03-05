{
  description = "A flake for building my NixOS configuration";

  # inputs.nixpkgs.url = github:NixOS/nixpkgs;
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-22.05;
    # nur.url = github:nix-community/NUR;
    #      home-manager = {
    #       url = github:nix-community/home-manager;
    #       inputs.nixpkgs.follows = "nixpkgs"; 
    #     };
    # 
  };
    
  # inputs.home-manager.url = github:nix-community/home-manager;


  
  outputs = { self, nixpkgs }: { # , home-manager}: # @attrs: {
    nixosConfigurations.ubunteous = nixpkgs.lib.nixosSystem {
      
      system = "x86_64-linux";
      # specialArgs = attrs; # access input from elsewhere
      modules = [
        ./configuration.nix
        # ./hardware-configuration.nix
      ];

      # Things in this set are passed to modules and accessible
      # in the top-level arguments (e.g. `{ pkgs, lib, inputs, ... }:`).
      # specialArgs = { inherit inputs; }; # define inputs above
    };
  };
}

  #     let 
  #       system = "x86_64-linux";

  #         inherit system;
  #         config.allowUnfree = true;
  #       };
  #       lib = nixpkgs.lib;
  #     in {
  #       nixosConfigurations = {
  #         MAIN = lib.nixosSystem { 
  #           inherit system;
  #           modules = [ 
  #             ./configuration.nix
  #             ./hardware-configuration.nix
  #             home-manager.nixosModules.home-manager {
  #               home-manager.useGlobalPkgs = true; 
  #               home-manager.useUserPackages = true;
  #               home-manager.users.mike = {
  #                 imports = [ ./hosts/MAIN/home.nix ];

  #               };
  #             }
  #           ];
  #         };
  #       };  
  #       nixbook = lib.nixosSystem { 
  #         inherit system;
  #         modules = [ 
  #           ./configuration.nix
  #           ./hardware-configuration.nix
  #         ];
  #       };
  #     };

  # }

