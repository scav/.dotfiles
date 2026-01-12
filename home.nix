{
  config,
  pkgs,
  inputs,
  ...
}:

let
  isDarwin = pkgs.stdenv.isDarwin;

  dotfiles = "${config.home.homeDirectory}/.dotfiles/.config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    zsh = "zsh";
    k9s = "k9s";
    fd = "fd";
  };

in
{
  imports = [
    ./nix-systems/common/tmux.nix
    ./nix-systems/common/nvim/nvim.nix
    inputs.mnw.homeManagerModules.mnw
    # inputs.nvf.homeManagerModules.nvf
    # ./nix-systems/common/nvf.nix
  ];

  home.sessionVariables = {
    MANPAGER = "nvim +Man!";
    MANWIDTH = "999";
  };

  programs.zsh = {
    enable = true;
    sessionVariables = {
      GPG_TTY = "$(tty)";
      MANPAGER = "nvim +Man!";
      MANWIDTH = "999";
    };
    initContent = ''
      source "$XDG_CONFIG_HOME/zsh/functions.zsh"
      source "$XDG_CONFIG_HOME/zsh/zoxide.zsh"
      source "$XDG_CONFIG_HOME/zsh/fzf.zsh"
    '';
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

  programs.ghostty = {
    enable = true; # if isDarwin then false else true;
    package = if isDarwin then null else pkgs.ghostty; # for nix-darwin we fetch it using homebrew
    enableZshIntegration = true;
    settings = builtins.fromTOML (builtins.readFile ./.config/ghostty/config);
  };

  programs.home-manager.enable = true;
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    gnumake
    act
    fzf
    (pkgs.nix-search-tv.overrideAttrs (old: {
      env = (old.env or { }) // {
        GOEXPERIMENT = "jsonv2";
      };

      installPhase = (old.installPhase or "") + ''
        install -Dm755 nixpkgs.sh $out/bin/ns
      '';
    }))
  ];

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;
}
