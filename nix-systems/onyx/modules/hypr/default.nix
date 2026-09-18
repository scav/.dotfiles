{ ... }:
{
  imports = [
    ./hyprextras.nix
    ./hyprpaper.nix
    ./hyprlock.nix
  ];

  wayland.windowManager.hyprland = {
    extraLuaFiles = {
      "hyprland-onyx.lua" = ./hyprland.lua;
    };
  };
}
