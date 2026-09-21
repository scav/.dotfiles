{ pkgs, ... }:
{
  imports = [
    ./hyprlock.nix
    ./hyprpaper.nix
  ];

  stylix.targets.hyprland = {
    enable = true;
    image.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    configType = "lua";
    extraConfig = builtins.readFile ./lua/hyprland.lua;
    extraLuaFiles = {
      "binds.lua" = ./lua/binds.lua;
      "rules.lua" = ./lua/rules.lua;
    };
  };

  home.packages = [
    pkgs.hyprshutdown
  ];
}
