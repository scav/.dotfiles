# waybar is loaded as with mkOutOfStoreSymlink while I configure it
{ pkgs, config, ... }:
{
  programs.waybar.enable = true;

  home.packages = with pkgs; [
    jq
  ];

  xdg.configFile."waybar" = {
    source = ./config;
    recursive = true;
  };
}
