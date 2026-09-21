{ config, pkgs, ... }:

{
  stylix = {
    cursor = {
      name = "XCursor-Pro-Dark";
      package = pkgs.xcursor-pro;
      size = 24;
    };

    targets = {
      hyprland.enable = true;
      fzf.enable = true;
      hyprlock.enable = false;
      waybar.enable = false;
    };
  };
}
