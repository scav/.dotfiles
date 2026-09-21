{ ... }:
{
  imports = [
    ./hypr
    ./waybar
    ./theme.nix
    ./rofi.nix
  ];

  services = {
    wob = {
      enable = true;
      systemd = true;
      settings = {
        "" = {
          border_size = 10;
          height = 50;
        };
      };
    };
  };

  stylix.targets.wob = {
    enable = true;
    opacity.enable = true;
  };

  programs.bat = {
    enable = true;
  };

  stylix.targets.bat = {
    enable = true;
    colors.enable = true;
  };

  stylix.targets.ashell = {
    enable = false; # waiting for updated style
  };

  programs.ashell = {
    enable = false;
    systemd.enable = false;
    settings = {
      appearance = {
        primary_color = "#7aa2f7";
        success_color = "#9ece6a";
        warning_color = "#e0af68";
        danger_color = "#f7768e";
        text_color = "#a9b1d6";

        workspace_colors = [
          "#7aa2f7"
          "#9ece6a"
        ];

        background_color = {
          base = "#1a1b26";
          weak = "#24273a";
          strong = "#414868";
        };
      };
    };
  };

}
