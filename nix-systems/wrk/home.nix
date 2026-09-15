{ pkgs, ... }:
{
  imports = [
    ./modules/aerospace
    ./desktoppr.nix
  ];

  programs.zsh = {
    shellAliases = {
      books = "cd $HOME/Library/Mobile Documents/com~apple~CloudDocs/calibre";
    };
  };

  home.packages = with pkgs; [
    (google-cloud-sdk.withExtraComponents [ google-cloud-sdk.components.gke-gcloud-auth-plugin ])
    dash0
    dokken-aws-helper
    scavpkgs.wxctl
  ];

  home.stateVersion = "26.05";
}
