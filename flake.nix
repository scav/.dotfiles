{
  description = "Scavs system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };



  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {

      imports = [
       ./nix/homebrew.nix
      ];

      environment.variables = {
        EDITOR = "nvim";
        XDG_CONFIG_HOME= "$HOME/.config";
      };

      environment.shellAliases = {
          nrs = "nix flake update;sudo darwin-rebuild switch --flake ~/.dotfiles";
      };

      environment.systemPackages = with pkgs; [ 
          act
          awscli2
          azure-cli
          bat
          buf
          cargo
          cilium-cli
          colima
          coreutils
          crossplane
          deno
          desktoppr
          devenv
          direnv
          docker
          docker-slim
          dyff
          entr
          eza
          fd
          firefox
          flyctl
          fzf
          gh
          git
          gnumake
          gnupg
          gnutls
          go
          go-tools
          golangci-lint
          gopls
          goreleaser
          gotestsum
          grpcurl
          jj
          jq
          k6
          ko
          k9s
          kind
          kubebuilder
          kubectl
          # kubelogin not building - RATELIMIT?
          kustomize
          kyverno
          lazygit
          libpq
          lima
          lua
          lua-language-server
          luarocks
          mkcert
          neovim
          nmap
          nodejs
          nushell
          openssh
          packer
          pinentry_mac
          protobuf
          qemu
          ripgrep
          ripsecrets
          sniffnet
          sops
          starship
          step-cli
          tailwindcss
          talosctl
          templ
          tree
          tree-sitter
          unbound
          utm
          watch
          wezterm
          wget
          yq
          yubikey-manager
          zoxide
          zsh
          zstd
      ];

      # Let determinate handle nix while nix-darwin handles MacOS
      nix.enable = false;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";
      nix.settings.trusted-users = ["root" "dag"];
      nix.settings.substituters = "https://devenv.cachix.org";
      nix.settings.trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";

      programs.zsh.enable = true;

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

      system.defaults = {
          finder.FXPreferredViewStyle = "clmv";
          dock.autohide = true;
          dock.mru-spaces = false;
          dock.show-recents = false;
          loginwindow.GuestEnabled = false;
          loginwindow.LoginwindowText = "NEOVIM TERMINAL";
          WindowManager.StandardHideWidgets = true;
      };
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#wrk
    darwinConfigurations."wrk" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };

    darwinPackages = self.darwinConfigurations."wrk".pkgs;
  };
}
