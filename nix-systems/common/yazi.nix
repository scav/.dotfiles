{ pkgs, ... }:
{
  stylix.targets.yazi = {
    enable = true;
  };

  programs.yazi = {
    enable = true;
    settings = {
      log = {
        enabled = false;
      };
      mgr = {
        show_hidden = true;
        sort_dir_first = true;
      };
    };
  };
}
