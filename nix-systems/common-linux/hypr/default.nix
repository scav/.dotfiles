{ config, ... }:
{
  imports = [
    ./hyprlock.nix
    ./hyprpaper.nix
  ];

  # todo: is this still needed?
  xdg.configFile."uwsm/env" = {
    source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
  };

  stylix.targets.hyprland = {
    enable = true;
    image.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    extraConfig = builtins.readFile ./lua/hyprland.lua;
    extraLuaFiles = {
      "startup.lua" = ./lua/startup.lua;
      "binds.lua" = ./lua/binds.lua;
      "rules.lua" = ./lua/rules.lua;
    };
  };
}
