{ ... }:
{
  programs.waybar = {
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
