{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [
    ./nix-systems/common/tmux
    ./nix-systems/common/nvim/nvim.nix
    inputs.mnw.homeManagerModules.mnw
    inputs.glide-browser.homeModules.default
    ./nix-systems/common/glide
    ./nix-systems/common/git
    ./nix-systems/common/ghostty.nix
    ./nix-systems/common/k9s.nix
    ./nix-systems/common/yazi.nix
    ./nix-systems/common/starship.nix
  ];

  xdg.enable = true;

  fonts.fontconfig.enable = true;

  stylix = {
    enable = true;
    autoEnable = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-storm.yaml";
    polarity = "dark";
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      sizes = {
        terminal = 14;
        applications = 12;
      };
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    sessionVariables = {
      GPG_TTY = "$(tty)";
      MANPAGER = "nvim +Man!";
      MANWIDTH = "997";
      EDITOR = "nvim";
    };
    initContent = builtins.concatStringsSep "\n" (
      map builtins.readFile [
        ./.config/zsh/functions.zsh
        ./.config/zsh/fzf.zsh
        ./.config/zsh/zoxide.zsh
        ./.config/zsh/zoxide.generated.zsh
      ]
    );
    shellAliases = {
      dotfiles = "cd $HOME/.dotfiles/";
      gpull = "git pull --rebase origin";
      gpush = "git push origin";
      gl = "git log --oneline --decorate --color";
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true; # faster direnv use_nix and use_flake
  };

  programs.fd = {
    enable = true;
    ignores = [
      "*.bak"
      "*.git"
      "~/go"
      "~/Library"
      "~/Downloads"
      "~/Applications"
      "~/.cargo"
    ];
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;

  };

  programs.home-manager.enable = true;

  programs.fzf.enable = true;

  programs.keepassxc = {
    enable = true;
  };

  programs.nix-search-tv = {
    enable = true;
    enableTelevisionIntegration = true;
    package = (
      pkgs.writeShellApplication {
        name = "ns";
        runtimeInputs = with pkgs; [
          fzf
          nix-search-tv
        ];
        text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
      }
    );
    settings = {
      indexes = [
        "nixpkgs"
        "nixos"
        "home-manager"
      ];
      update_interval = "24h";
      enable_waiting_message = true;
    };
  };

  home.packages = with pkgs; [
    gh
    gnumake
    keymapp
    ripgrep
    ripsecrets
    slack
    zoxide
    yubikey-manager
    wget
    curl
  ];
}
