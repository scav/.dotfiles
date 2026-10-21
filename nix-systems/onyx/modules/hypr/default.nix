{ ... }:
{
  imports = [
    ./hyprextras.nix
    ./hyprlock.nix
  ];

  wayland.windowManager.hyprland = {
    extraLuaFiles = {
      "hyprland-onyx.lua" = ./hyprland.lua;
    };
  };
}
