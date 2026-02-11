# waybar is loaded as with mkOutOfStoreSymlink while I configure it
{ pkgs, config, ... }:
let
  dotfiles = "${config.home.homeDirectory}/.dotfiles/nix-systems/onyx/modules/waybar";
in

{
  programs.waybar.enable = true;

  home.packages = with pkgs; [
    jq
  ];

  xdg.configFile."waybar" = {
    source = config.lib.file.mkOutOfStoreSymlink dotfiles;
    recursive = true;
  };
}
