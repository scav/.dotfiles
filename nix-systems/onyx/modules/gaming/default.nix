{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.starsector
  ];

  programs.discord = {
    enable = true;
    settings.SKIP_HOST_UPDATE = true;
  };
}
