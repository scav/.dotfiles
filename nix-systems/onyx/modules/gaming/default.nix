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
            ", mouse:275, pass, class:^(discord)$"
            ", mouse:276, pass, class:^(discord)$"
            "$mainMod, G, submap, reset"
          ];
        };
      };
    };
  };
}
