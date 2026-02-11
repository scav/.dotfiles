{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    jq
  ];

  xdg.configFile."waybar" = {
    source = config.lib.file.mkOutOfStoreSymlink ./.;
    recursive = true;
  };
}
