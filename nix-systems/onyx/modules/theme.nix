{ config, pkgs, ... }:

{
  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-storm.yaml";
    polarity = "dark";
    cursor = {
      name = "XCursor-Pro-Dark";
      package = pkgs.xcursor-pro;
      size = 1;
    };
  };

  stylix.targets.hyprland = {
    enable = true;
  };

  stylix.targets.fzf = {
    enable = true;
  };

  stylix.targets.hyprlock = {
    enable = false;
  };

  stylix.targets.waybar = {
    enable = false;
  };
}
