{
  description = "Jordan Steinke's NixOS & Home-Manager config";

  inputs = {
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ disko, home-manager, nixpkgs, stylix, ... }:
  let
    mkHost = { hostName, extraModules ? [], useStylix ? true }:
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configurations/${hostName}
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jordan.imports = [
              ./configurations/${hostName}/home.nix
            ];
          }
          inputs.disko.nixosModules.disko
          inputs.sops-nix.nixosModules.sops
        ] ++ nixpkgs.lib.optionals useStylix [ stylix.nixosModules.stylix ]
          ++ extraModules;
      };
  in {
    nixosConfigurations = {
      desktop-jordan = mkHost { hostName = "desktop-jordan"; };
      laptop-jordan = mkHost { hostName = "laptop-jordan"; };
      webserver = mkHost { hostName = "webserver"; useStylix = false; };
      iso = mkHost {
        hostName = "iso";
        extraModules = [
          (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
        ];
      };
    };
  };
}
