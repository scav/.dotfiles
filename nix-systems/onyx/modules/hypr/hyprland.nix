{ config, ... }:

{
  # uswm
  xdg.configFile."uwsm/env" = {
    source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    # conflicts with uwsm
    systemd.enable = true;
    settings = {

      monitor = ",5120x1440@240,auto,1.0";

      "$terminal" = "ghostty";
      "$fileManager" = "yazi";
      "$menu" = "rofi -show drun";
      "$reload_waybar" = "pkill waybar; waybar &";
      "$snip" = "snip";

      exec-once = "waybar & hyprpaper & ";
      misc = {
        force_default_wallpaper = 0; # Disable anime cringe
        disable_hyprland_logo = true; # Disable anime cringe
      };

      env = [
        "GTK_THEME,Tokyo-Night-Dark"
        "GTK_ICON_THEME,Adwaita"
        "XCURSOR_THEME,Adwaita"
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
      ];

      general = {
        gaps_in = 1;
        gaps_out = 1;
        border_size = 1;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      master = {
        new_status = "master";
      };

      decoration = {
        rounding = 0;
        rounding_power = 0;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;
      };

      dwindle = {
        pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # You probably want this
      };

      input = {
        kb_layout = "us,no";
        kb_variant = ",";
        kb_options = "grp:alt_space_toggle";
        follow_mouse = 1;
        sensitivity = 2;
        repeat_rate = 35;
        repeat_delay = 200;
        touchpad = {
          natural_scroll = false;
        };
      };

      cursor = {
        inactive_timeout = 30;
        no_hardware_cursors = true;
      };

      "$mainMod" = "SUPER";
      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];
      bindl = [
        ", XF86AudioPlay, exec, playerctl play-pause"
      ];
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bind = [

        "$mainMod, F, exec, ghostty -e yazi"

        "$mainMod, Control_L, exec, hyprctl switchxkblayout current next"

        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"

        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        "$mainMod, Return, exec, $terminal"
        "$mainMod, Q, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating,"
        "$mainMod, SPACE, exec, $menu"
        "$mainMod, R, exec, $reload_waybar"

        # Move focus with mainMod + arrow keys
        "$mainMod, l, movefocus, l"
        "$mainMod, h, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
      ];

    };
  };
}
