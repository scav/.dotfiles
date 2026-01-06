{ config, ... }:
{
  imports = [
    ./homebrew.nix
    ./packages.nix
  ];

  environment.shellAliases = {
    nrs = "nix flake update;sudo darwin-rebuild switch --flake ~/.dotfiles";
  };

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

  system.configurationRevision = config.rev or config.dirtyRev or null;

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
}
