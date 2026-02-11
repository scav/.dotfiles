{ ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      wallpaper = [
        {
          monitor = "";
          # todo: fetch this automatically
          path = "/home/scav/.dotfiles/nix-systems/onyx/config/wallpapers/wide_tokyonight_skyline.jpg";

          fit_mode = "fill";
        }
      ];
    };
  };
}
