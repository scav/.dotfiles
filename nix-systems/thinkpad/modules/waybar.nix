{ ... }:
{
  programs.waybar = {
    enable = true;
    style = builtins.readFile ./config/style.css;
    settings = {
      mainBar = {
        modules-right = [
          "custom/sep"
          "battery"
        ];
      };
    };
  };
}
