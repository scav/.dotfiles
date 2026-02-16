{ config, pkgs, ... }:
{
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    (google-cloud-sdk.withExtraComponents [ google-cloud-sdk.components.gke-gcloud-auth-plugin ])
  ];
}
