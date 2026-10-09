{
  pkgs,
  ...
}:
{
  imports = [ ./bookmarks.nix ];

  programs.glide-browser = {
    enable = true;
    nativeMessagingHosts = [ pkgs.keepassxc ];
    profiles = {
      scav = {
        id = 0;
        name = "scav";
        isDefault = true;
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
        "@contain-facebook" = {
          default_area = "navbar";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/facebook-container/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
      };
    };
  };

}
