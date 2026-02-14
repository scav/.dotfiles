{
  description = "Scavs system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.3";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mnw.url = "github:Gerg-L/mnw";
    glide-browser = {
      url = "github:glide-browser/glide.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      lanzaboote,
      nix-darwin,
      nixpkgs,
      home-manager,
      glide-browser,
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
              users.dag.imports = [
                ./home.nix
                ./nix-systems/wrk/home.nix
              ];
              extraSpecialArgs = { inherit inputs; };
            };
          }
        ];
      };

      nixosConfigurations."onyx" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          lanzaboote.nixosModules.lanzaboote

          (
            { pkgs, lib, ... }:
            {
              environment.systemPackages = [
                pkgs.sbctl
              ];

              # Lanzaboote currently replaces the systemd-boot module.
              # This setting is usually set to true in configuration.nix
              # generated at installation time. So we force it to false
              # for now.
              boot.loader.systemd-boot.enable = lib.mkForce false;
              boot.lanzaboote = {
                enable = true;
                pkiBundle = "/var/lib/sbctl";
              };
            }
          )

          ./nix-systems/onyx/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.scav = {
                imports = [
                  ./home.nix
                  ./nix-systems/onyx/home.nix
                ];
              };
              extraSpecialArgs = {
                inherit inputs;
              };
              backupFileExtension = "backup";
            };
          }
        ];
      };
    };
}
