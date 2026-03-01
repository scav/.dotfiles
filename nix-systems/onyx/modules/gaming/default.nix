{ config, ... }:

{

  wayland.windowManager.hyprland = {
    settings = {

      windowrule = [
        "fullscreen 1, match:class ^steam_app_.*"
      ];
      bind = [
        "$mainMod, G, submap, Gaming"
        "$mainMod, Q, killactive, match:class ^((?!steam_app_).)*\$"
        "$mainMod, F,exec, hyprctl dispatch windowfullscreen toggle"
      ];

    };

    submaps = {
      Gaming = {
        settings = {
          bind = [
            "$mainMod, G, submap, reset"
          ];
        };
      };
    };
  };
}
