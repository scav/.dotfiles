{ config, pkgs, ... }:
{
  imports = [
    ../common-linux
    ./modules/hypr
    ./modules/gaming
  ];

  xdg.configFile."uwsm/env".source =
    "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";

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

  home.packages = with pkgs; [
    sops
    file
    playerctl
    wl-clipboard
    scavpkgs.wxctl
    opencode
  ];

}
