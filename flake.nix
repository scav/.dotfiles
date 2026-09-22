{
  description = "Scavs system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.1.0";
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
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    scavpkgs = {
      url = "git+ssh://git@github.com/scav/scavpkgs";
    };
    dokken-aws-helper = {
      url = "git+ssh://git@github.com/tv2norge/dokken-aws-helper";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      lanzaboote,
      nix-darwin,
      nixpkgs,
      stylix,
      scavpkgs,
      home-manager,
      dokken-aws-helper,
      ...
    }@inputs:
    let
      configuration =
        { pkgs, ... }:
        {
          fonts.packages = with pkgs; [
            nerd-fonts.jetbrains-mono
          ];
          nixpkgs.overlays = [
            (_: prev: {
              inherit (prev.lixPackageSets.stable)
                nixpkgs-review
                nix-eval-jobs
                nix-fast-build
                colmena
                ;
              dokken-aws-helper = dokken-aws-helper.packages.${pkgs.stdenv.hostPlatform.system}.default;
            })
            scavpkgs.overlays.default
            (import ./nix-systems/common/overlays)
          ];

          nix.registry = {
            scavpkgs.flake = inputs.scavpkgs;
            nixpkgs.flake = inputs.nixpkgs;
          };

          nix.package = pkgs.lixPackageSets.stable.lix;
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
                stylix.homeModules.stylix
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
          configuration
          ./nix-systems/onyx/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.scav = {
                imports = [
                  stylix.homeModules.stylix
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
      nixosConfigurations."thinkpad" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          lanzaboote.nixosModules.lanzaboote
          (
            { pkgs, lib, ... }:
            {
              environment.systemPackages = [
                pkgs.sbctl
              ];
              boot.loader.systemd-boot.enable = lib.mkForce false;
              boot.lanzaboote = {
                enable = true;
                pkiBundle = "/var/lib/sbctl";
              };
            }
          )
          configuration
          ./nix-systems/thinkpad/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.scav = {
                imports = [
                  stylix.homeModules.stylix
                  ./home.nix
                  ./nix-systems/thinkpad/home.nix
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
