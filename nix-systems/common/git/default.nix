{ config, ... }:
{
  programs.git = {
    enable = true;
    signing = {
      signByDefault = true;
      format = "ssh";
      key = "${config.home.homeDirectory}/.ssh/id_ed25519_sk_rk";
    };
    settings = {
      tag.gpgSign = true;
      commit.gpgsign = true;
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
