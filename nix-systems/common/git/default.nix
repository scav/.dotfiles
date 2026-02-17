{ config, ... }:
{
  programs.git = {
    enable = true;
    signing = {
      signByDefault = false;
      format = "ssh";
      key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
    };
    settings = {
      init = {
        defaultBranch = "main";
      };
      user = {
        name = "Dag Østgulen Heradstveit";
        email = "190020+scav@users.noreply.github.com";
      };
    };
  };
}
