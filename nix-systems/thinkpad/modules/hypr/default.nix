{ ... }:
{
  wayland.windowManager.hyprland = {
    extraLuaFiles = {
      "monitors.lua" = ./monitors.lua;
      "startup-thinkpad.lua" = ./startup.lua;
    };
  };
}
