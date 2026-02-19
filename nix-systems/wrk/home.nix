{ config, pkgs, ... }:
{
  imports = [
    ./modules/aerospace
    ./desktoppr.nix
  ];

  home.packages = with pkgs; [
    (google-cloud-sdk.withExtraComponents [ google-cloud-sdk.components.gke-gcloud-auth-plugin ])
  ];

  home.stateVersion = "26.05";
}
