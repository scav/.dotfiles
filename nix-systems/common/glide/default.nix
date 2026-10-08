{
  config,
  pkgs,
  ...
}:
{
  programs.glide-browser = {
    enable = true;
    nativeMessagingHosts = [ pkgs.keepassxc ];
    profiles = {
      scav = {
        id = 0;
        name = "scav";
        isDefault = true;
        bookmarks = [
          {
            name = "Nix sites";
            toolbar = true;
            bookmarks = [
              {
                name = "homepage";
                url = "https://nixos.org/";
              }
              {
                name = "wiki";
                tags = [
                  "wiki"
                  "nix"
                ];
                url = "https://wiki.nixos.org/";
              }
            ];
          }
        ];
      };
    };
    policies = {
      BlockAboutConfig = true;
      DefaultDownloadDirectory = "\${home}/Downloads";
      # To get extension ID scroll to bottom and click "Copy add-on ID"
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          default_area = "navbar";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
        "keepassxc-browser@keepassxc.org" = {
          default_area = "navbar";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
      };
    };
  };

}
