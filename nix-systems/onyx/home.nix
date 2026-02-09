{ config, pkgs, ... }:
let
  dotfiles = "${config.home.homeDirectory}/.dotfiles/nix-systems/onyx/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    wofi = "wofi";
    rofi = "rofi";
    foot = "foot";
    waybar = "waybar";
  };
in
{
  imports = [
    ./modules/theme.nix
    ./modules/hypr/hyprland.nix
    ./modules/hypr/hyprextras.nix
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
    };
    profileExtra = ''
      if uwsm check may-start; then
          exec uwsm start hyprland.desktop
      fi
    '';
  };

  # conflicts with uwsm
  wayland.windowManager.hyprland.systemd.enable = false;

  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      wallpaper = [
        {
          monitor = "";
          # todo: fetch this automatically
          path = "/home/scav/.dotfiles/nix-systems/onyx/config/wallpapers/wide_tokyonight_skyline.jpg";

          fit_mode = "fill";
        }
      ];
    };
  };

  home.packages = with pkgs; [
    tree-sitter
    file
    gcc
    gh
    ripgrep
    nil
    wofi
    rofi
    slack
    discord
    yazi
    playerctl
    tree
    pcmanfm
  ];

}
