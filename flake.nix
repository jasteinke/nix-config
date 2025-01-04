{
  description = "Jordan Steinke's NixOS & Home-Manager config";

  inputs = {
    catppuccin.url = "github:catppuccin/nix";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";


    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = inputs@{ catppuccin, disko, home-manager, nixpkgs, ... }:{
    nixosConfigurations = {
      redwood = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          catppuccin.nixosModules.catppuccin
          ./hosts/redwood
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jordan.imports = [
              catppuccin.homeManagerModules.catppuccin
              ./hosts/redwood/home.nix
            ];

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
          inputs.disko.nixosModules.disko
          inputs.sops-nix.nixosModules.sops
        ];
      };
    };
  };
}
