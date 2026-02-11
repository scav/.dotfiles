{ pkgs, ... }:
let
  tokiyoNight = pkgs.fetchFromGitHub {
    owner = "kalidyasin";
    repo = "yazi-flavors";
    rev = "v1.2.0";
    sha256 = "sha256-9I6NWIlNi4y0mNuqX8AbjfIK9vrC3+fzP0dJdh6QAic=";
  };
in
{
  programs.yazi = {
    enable = true;
    flavors = {
      tokyonight-storm = "${tokiyoNight}/tokyonight-storm.yazi";
    };
    settings = {
      log = {
        enabled = false;
      };
      mgr = {
        show_hidden = true;
        sort_dir_first = true;
      };
    };
    theme = {
      flavor = {
        dark = "tokyonight-storm";
      };
    };
  };
}
