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

}
