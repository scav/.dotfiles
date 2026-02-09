{ pkgs, ... }:

{
  home.packages = with pkgs; [ brightnessctl ];
  # Add binding to hyprland.conf
  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        "$mainMod, X, exec, hyprlock"
      ];
    };
  };

  programs.hyprlock = {
    enable = true;
    extraConfig = builtins.readFile ./hyprlock.conf;
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [

        # Turn down monitor
        {
          timeout = 150;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        # Turn off keyboard backlight
        {
          timeout = 150;
          on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
          on-resume = "brightnessctl -rd rgb:kbd_backlight";
        }
        # Lock screen
        {
          timeout = 150;
          on-timeout = "loginctl lock-session";
        }

        # Turn screen off
        {
          timeout = 300;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
        }
        # Susped system
        {
          timeout = 600;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
