{ config, pkgs, ... }:
let
  dotfiles = "${config.home.homeDirectory}/.dotfiles/nix-systems/onyx/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    rofi = "rofi";
    waybar = "waybar";
  };
in
{
  imports = [
    ./modules/theme.nix
    ./modules/hypr
  ];

  # Initialize all config files imported at the top
  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;

  home.username = "scav";
  home.homeDirectory = "/home/scav";
  home.stateVersion = "26.05";
  programs.zsh = {
    enable = true;
    shellAliases = {
      nru = "nix flake update; sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/.dotfiles#onyx";
      nrs = "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/.dotfiles#onyx";
      # Yep...
      pbcopy = "wl-copy ";
      pbpaste = "wl-paste ";
    };
    profileExtra = ''
      if uwsm check may-start; then
          exec uwsm start hyprland.desktop
      fi
    '';
  };

  home.packages = with pkgs; [
    file
    gcc
    gh
    ripgrep
    nil
    rofi
    slack
    discord
    playerctl
    tree
    pcmanfm
    wl-clipboard
  ];

}
