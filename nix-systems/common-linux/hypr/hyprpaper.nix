{ pkgs, ... }:

let
  wallpapers = pkgs.fetchFromGitHub {
    owner = "mylinuxforwork";
    repo = "wallpaper";
    rev = "main";
    sha256 = "sha256-g4f8B5cCI9+3HSpjs+YWARNHHJpbufoz/ocYqptnPzg=";
  };
in
{
  services.hyprpaper = {
    enable = true;
    systemdTarget = "graphical-session.target";
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
