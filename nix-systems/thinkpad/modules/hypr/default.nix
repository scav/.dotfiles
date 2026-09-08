{ ... }:
{
  wayland.windowManager.hyprland = {
    extraLuaFiles = {
      "monitors.lua" = ./monitors.lua;
    };
  };
}
