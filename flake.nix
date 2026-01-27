{
  description = "Scavs system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-pinned.url = "github:NixOS/nixpkgs/70801e06d9730c4f1704fbd3bbf5b8e11c03a2a7";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mnw.url = "github:Gerg-L/mnw";
  };
  outputs =
    {
      self,
      nix-darwin,
      nixpkgs,
      nixpkgs-pinned,
      home-manager,
      ...
    }@inputs:
    let
      configuration =
        { pkgs, ... }:
        {
          fonts.packages = with pkgs; [
            nerd-fonts.jetbrains-mono
          ];
        };

    in
    {
      overlays.swift-from-pinned =
        final: prev:
        let
          pinnedPkgs = import nixpkgs-pinned {
            inherit (prev) system;
            config = prev.config;
          };
        in
        {
          swift = pinnedPkgs.swift;
          swiftPackages = pinnedPkgs.swiftPackages;
        };

      darwinConfigurations."wrk" = nix-darwin.lib.darwinSystem {
        modules = [
          (
            { ... }:
            {
              nixpkgs.overlays = [
                self.overlays.swift-from-pinned
              ];
            }
          )
          configuration
          ./nix-systems/wrk/configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              backupFileExtension = "backup";
              useGlobalPkgs = true;
              useUserPackages = true;
              users.dag = import ./home.nix;
              extraSpecialArgs = { inherit inputs; };
            };
          }
        ];
      };
      # TODO: add onyx here
    };
}
