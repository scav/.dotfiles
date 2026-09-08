{ pkgs, ... }:

let
  wallpapers = pkgs.fetchFromGitHub {
    owner = "mylinuxforwork";
    repo = "wallpaper";
    rev = "main";
    sha256 = "sha256-a3GwidRDy8Ke2V5EHwHEZr1smSgNG3N70faZ2lCrmnw=";
  };
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      wallpaper = [
        {
          monitor = "";
          path = "${wallpapers}/astronaut_jellyfish.jpg";
          fit_mode = "fill";
        }
      ];
    };
  };
}
