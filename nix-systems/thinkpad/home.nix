{ config, pkgs, ... }:
{
  imports = [
    ../common-linux/rofi.nix
    ../common-linux/theme.nix
    ../common-linux/waybar
    ../common-linux/hypr
    ./modules/hypr
  ];

  home.username = "scav";
  home.homeDirectory = "/home/scav";
  home.stateVersion = "26.05";
  programs.zsh = {
    enable = true;
    shellAliases = {
      nrt = "nix flake update; sudo nixos-rebuild test --flake ${config.home.homeDirectory}/.dotfiles#thinkpad";
      nru = "nix flake update; sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/.dotfiles#thinkpad";
      nrs = "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/.dotfiles#thinkpad";
      # Yep...
      pbcopy = "wl-copy ";
      pbpaste = "wl-paste ";
    };
  };

  xdg = {
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplicationPackages = [
        config.programs.glide-browser.package
      ];
    };
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
    playerctl
    wl-clipboard
    wxctl
  ];

}
