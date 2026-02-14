{ pkgs, ... }:
let
  tokiyoNight = pkgs.fetchFromGitHub {
    owner = "kalidyasin";
    repo = "yazi-flavors";
    rev = "v1.2.0";
    sha256 = "sha256-3zpXpTX8AydHyNFes5XI7VfNTRCjNiB9e9R10s1NKdI=";
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
