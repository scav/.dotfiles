{ ... }:
{
  programs.waybar = {
    systemd = {
      enable = true;
      targets = [
        "hyprland-session.target"
      ];
    };
    settings = {
      mainBar = {
        modules-right = [
          "custom/sep"
          "battery"
          "custom/sep"
        ];
      };
    };
  };
}
