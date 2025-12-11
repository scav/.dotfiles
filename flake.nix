{
  description = "Scavs system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
    }@inputs:
    let
      configuration =
        { pkgs, ... }:
        {

          imports = [
            ./nix/homebrew.nix
            ./nix/packages.nix
          ];

          environment.variables = {
            EDITOR = "nvim";
            XDG_CONFIG_HOME = "$HOME/.config";
          };

          environment.shellAliases = {
            nrs = "nix flake update;sudo darwin-rebuild switch --flake ~/.dotfiles";
          };

          fonts.packages = with pkgs; [
            nerd-fonts.jetbrains-mono
          ];

          # Let determinate handle nix while nix-darwin handles MacOS
          nix.enable = false;

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";
          nix.settings.trusted-users = [
            "root"
            "dag"
          ];
          nix.settings.substituters = "https://devenv.cachix.org";
          nix.settings.trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";

          programs.zsh.enable = true;
          programs.direnv.enable = true;

          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 6;
          system.primaryUser = "dag";

          # The platform the configuration will be used on.
          nixpkgs = {
            hostPlatform = "aarch64-darwin";
            config.allowUnfree = true;
          };

          users.users.dag = {
            name = "dag";
            home = "/Users/dag/";
          };

          system.defaults = {
            finder.FXPreferredViewStyle = "clmv";
            dock.autohide = true;
            dock.mru-spaces = false;
            dock.show-recents = false;
            loginwindow.GuestEnabled = false;
            loginwindow.LoginwindowText = "NEOVIM TERMINAL";
            NSGlobalDomain.NSWindowShouldDragOnGesture = true;
            WindowManager.StandardHideWidgets = true;
          };
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#wrk
      darwinConfigurations."wrk" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
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

      darwinPackages = self.darwinConfigurations."wrk".pkgs;
    };
}
