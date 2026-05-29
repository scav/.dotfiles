{ config, ... }:

{

  wayland.windowManager.hyprland = {
    settings = {

      windowrule = [
        "fullscreen 1, match:class ^steam_app_.*"
      ];
      bind = [
        # ", mouse:275, pass, class:^(discord)$"
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

  programs.discord = {
    enable = true;
    settings.SKIP_HOST_UPDATE = true;
  };
}
