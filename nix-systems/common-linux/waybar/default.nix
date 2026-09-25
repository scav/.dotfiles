{ pkgs, config, ... }:
let
  toggleKeyMap = pkgs.writeShellScriptBin "tkm" ''
    #!/usr/bin/env bash
    KEYMAP=$(hyprctl devices -j | ${pkgs.jq}/bin/jq -r '
      .keyboards[]
      | select(.main == true)
      | if .active_layout_index == 0 then "  US 🇺🇸 "
        elif .active_layout_index == 1 then "  NO 🇳🇴"
        else " UNKNOWN"
        end
        ')
    echo -n $KEYMAP
  '';
in
{

  home.packages = with pkgs; [
    jq
  ];

  # include scripts
  xdg.configFile."waybar/scripts" = {
    source = ./config/scripts;
    recursive = true;
  };

  programs.waybar = {
    enable = true;
    systemd.targets = [ "graphical-session.target" ];
    style = builtins.readFile ./config/style.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 4;

        modules-left = [
          "hyprland/workspaces"
          "custom/sep"
          "custom/playerctl"
        ];
        # modules-center = [ "hyprland/window" ];
        modules-right = [
          "custom/sep"
          "cpu"
          "load"
          "temperature"
          "memory"
          # "custom/nvidia"
          "disk"
          "custom/sep"
          "network"
          "custom/sep"
          "custom/wxctl"
          "custom/sep"
          "custom/keymap"
          "hyprland/submap"
          "custom/sep"
          "pulseaudio"
          "custom/sep"
          "clock"
          "custom/sep"
          "tray"
        ];

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          warp-on-scroll = false;
          format = "{name}";
        };

        "hyprland/window" = {
          max-length = 40;
          seperate-outputs = false;
        };

        "hyprland/submap" = {
          format = "{}";
          always-on = true;
          max-length = 15;
          tooltip = true;
        };

        tray = {
          icon-size = 20;
          spacing = 10;
        };

        clock = {
          format = "{:%H:%M}  ";
          format-alt = "{:%Y-%m-%d}";
        };

        cpu = {
          format = " {usage}%";
          tooltip = false;
          interval = 30;
        };

        load = {
          format = "({})";
          tooltip = false;
          interval = 30;
        };

        memory = {
          interval = 30;
          format = " {used:0.1f}G/{total:0.1f}G";
        };

        disk = {
          interval = 30;
          path = "/";
          format = "󰋊 {free}/{total}";
          unit = "GB";
        };

        temperature = {
          format = "{temperatureC}°C {icon}";
          tooltip = true;
          interval = 5;
        };

        network = {
          format-ethernet = "󰛶 {bandwidthUpBits} 󰛴 {bandwidthDownBits} 󰩠 {ipaddr}";
          format-wifi = "󰛶 {bandwidthUpBits} 󰛴 {bandwidthDownBits} 󰩠 {ipaddr}";
          format-disconnected = "Disconnected ⚠";
          interval = 5;
        };

        "custom/sep" = {
          format = "|";
          interval = 0;
        };

        "custom/intersep" = {
          format = "_";
          interval = 0;
        };

        pulseaudio = {
          format = "{volume}% {icon}";
          format-muted = " ";
          format-icons = {
            muted = "";
            default = [
              " "
              " "
            ];
          };
          scroll-step = 1;
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };

        "custom/keymap" = {
          exec = "${toggleKeyMap}/bin/tkm";
          signal = 8;
        };

        "custom/wxctl" = {
          exec = "wxctl -n bergen -c norway";
          interval = 600;
        };

        "custom/nvidia" = {
          exec = "nvidia-smi --query-gpu=utilization.gpu,temperature.gpu --format=csv,nounits,noheader | sed 's/\\([0-9]\\+\\), \\([0-9]\\+\\)/\\1% \\2°C/g'";
          format = "󰍹 {}";
          interval = 30;
        };
      };
    };
  };
}
