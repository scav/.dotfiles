{ config, pkgs, ... }:
let
in
{
  imports = [
    ./modules/rofi.nix
    ./modules/theme.nix
    ./modules/hypr
    ./modules/waybar
    ./modules/gaming
  ];

  home.username = "scav";
  home.homeDirectory = "/home/scav";
  home.stateVersion = "26.05";
  programs.zsh = {
    enable = true;
    shellAliases = {
      nrt = "nix flake update; sudo nixos-rebuild test --flake ${config.home.homeDirectory}/.dotfiles#onyx";
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

  services.wob = {
    enable = true;
    systemd = true;
    settings = {
      "" = {
        border_size = 10;
        height = 50;
      };
    };
  };
  stylix.targets.wob.enable = true;

  home.packages = with pkgs; [
    file
    gcc
    playerctl
    pcmanfm
    wl-clipboard
    wxctl
    opencode
  ];

}
