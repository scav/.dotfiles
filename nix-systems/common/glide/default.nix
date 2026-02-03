{ pkgs, inputs, ... }:
{
  xdg = {
    configFile."glide" = {
      enable = true;
      recursive = true;
      source = ./config;
    };
  };

  home.packages = [
    inputs.glide-browser.packages.${pkgs.system}.default
  ];
}
