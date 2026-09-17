{ ... }:
{
  imports = [
    ./hyprlock.nix
  ];

  wayland.windowManager.hyprland = {
    extraLuaFiles = {
      "monitors.lua" = ./monitors.lua;
      "startup-thinkpad.lua" = ./startup.lua;
      "hyprland-thinkpad.lua" = ./hyprland.lua;
    };
  };

  services.hyprpolkitagent.enable = true;

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        # after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
      };

      listener = [

        # Turn down monitor
        {
          timeout = 60;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        # Turn off keyboard backlight
        {
          timeout = 120;
          on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
          on-resume = "brightnessctl -rd rgb:kbd_backlight";
        }
        # Lock screen
        {
          timeout = 120;
          on-timeout = "loginctl lock-session";
        }

        # Turn screen off
        {
          timeout = 120;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

}
