{ pkgs, ... }:
{
  imports = [
    ./modules/aerospace
    ./desktoppr.nix
  ];

  home.packages = with pkgs; [
    (google-cloud-sdk.withExtraComponents [ google-cloud-sdk.components.gke-gcloud-auth-plugin ])
    dash0
  ];

  home.stateVersion = "26.05";
}
