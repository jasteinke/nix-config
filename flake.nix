{
  description = "Jordan Steinke's NixOS & Home-Manager config";

  inputs = {
    browser-previews.url = "github:nix-community/browser-previews";
    browser-previews.inputs.nixpkgs.follows = "nixpkgs";

    catppuccin.url = "github:catppuccin/nix";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = inputs@{ catppuccin, disko, home-manager, nixpkgs, ... }:{
    nixosConfigurations = {
      webguest = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configurations/webguest
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jordan.imports = [
              ./configurations/webguest/home.nix
            ];
          }
          inputs.disko.nixosModules.disko
          inputs.sops-nix.nixosModules.sops
        ];
      };
      hybridhost = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          catppuccin.nixosModules.catppuccin
          ./configurations/hybridhost
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jordan.imports = [
              catppuccin.homeManagerModules.catppuccin
              ./configurations/hybridhost/home.nix
            ];
          }
          inputs.disko.nixosModules.disko
          inputs.sops-nix.nixosModules.sops
        ];
      };
      iso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jordan.imports = [
              catppuccin.homeManagerModules.catppuccin
              ./configurations/iso/home.nix
            ];
          }
          ./configurations/iso
          (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
        ];
      };
    };
  };
}
