{
  description = "Scavs system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      # url = "github:nix-darwin/nix-darwin/master";
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
      darwinConfigurations."wrk" = nix-darwin.lib.darwinSystem {
        modules = [
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
