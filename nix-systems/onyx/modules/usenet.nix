{ config, pkgs, ... }:
{
  services = {
    jellyfin = {
      enable = true;
      openFirewall = true;
      user = "scav";
    };

    nzbget = {
      enable = true;
      user = "scav";
      group = "users";
      settings = {
        ControlUsername = "admin";
        ControlPassword = "password";
        MainDir = "/home/scav/STUFF";
        ArticleCache = "1000";

        "Server1.Name" = "default";
        "Server1.Optional" = "no";
        "Server1.Host" = "news.eweka.nl";
        "Server1.Port" = "563";
        "Server1.Encryption" = "yes";
        "Server1.JoinGroup" = "no";
        "Server1.Connections" = "50";
      };
    };

  };

  systemd.services.nzbget = {
    preStart = ''
      config=/var/lib/nzbget/nzbget.conf

      # Remove any old copies of the secrets.
      sed -i \
      -e '/^Server1\.Username=/d' \
      -e '/^Server1\.Password=/d' \
      "$config"

      # Inject the decrypted secrets at runtime.
      printf 'Server1.Password=%s\n' \
      "$(cat /home/scav/tmp/pass.txt)" \
      >> "$config"

      printf 'Server1.Username=%s\n' \
      "$(cat /home/scav/tmp/user.txt)" \
      >> "$config"

      chmod 0600 "$config"
    '';
  };
}
