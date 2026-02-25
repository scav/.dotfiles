{ pkgs, ... }:

let
  backgrounds = pkgs.fetchFromGitHub {
    owner = "RickTimmer";
    repo = "wallpaper";
    rev = "main";
    sha256 = "";
  };
in
{
  programs.desktoppr.settings = {
    enable = true;
    settings = {
      picture = "${backgrounds}/moonlight.jpg";
    };
  };
}
