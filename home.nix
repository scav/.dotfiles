{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./nix-systems/common/tmux.nix
    ./nix-systems/common/nvim/nvim.nix
    inputs.mnw.homeManagerModules.mnw
    ./nix-systems/common/k9s.nix
    ./nix-systems/common/glide
    ./nix-systems/common/git
    ./nix-systems/common/ghostty
    ./nix-systems/common/yazi.nix
  ];

  xdg.enable = true;

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
      books = "cd $HOME/Library/Mobile\ Documents/com~apple~CloudDocs/calibre";
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

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = builtins.fromTOML (builtins.readFile ./.config/starship.toml);
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

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-bin;
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;

  };

  programs.home-manager.enable = true;
  # home.stateVersion = "26.05";

  home.packages = with pkgs; [
    discord
    fzf
    gh
    gnumake
    keymapp
    nil
    ripgrep
    ripsecrets
    slack
    zoxide
    yubikey-manager
    (pkgs.nix-search-tv.overrideAttrs (old: {
      env = (old.env or { }) // {
        GOEXPERIMENT = "jsonv2";
      };

      installPhase = (old.installPhase or "") + ''
        install -Dm755 nixpkgs.sh $out/bin/ns
      '';
    }))
  ];

}
