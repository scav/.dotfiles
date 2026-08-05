{ pkgs, ... }:
{
  imports = [
    ./modules/aerospace
    ./desktoppr.nix
  ];

  shellAliases = {
    books = "cd $HOME/Library/Mobile Documents/com~apple~CloudDocs/calibre";
  };

  home.packages = with pkgs; [
    (google-cloud-sdk.withExtraComponents [ google-cloud-sdk.components.gke-gcloud-auth-plugin ])
    dash0
    dokken-aws-helper
  ];

  home.stateVersion = "26.05";
}
