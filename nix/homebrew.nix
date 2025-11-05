{ config, pkgs, ... }:

{

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap"; # remove unlisted brews/casks
      autoUpdate = true;
      upgrade = true;
    };

    taps = [
      "azure/kubelogin"
      # "FelixKratz/formulae"
    ];

    brews = [
      # {   name = "sketchybar";
      #     start_service = true;
      # }
      "aws-sam-cli"
      "make"
      "kiota"
      "mockery"
      "whalebrew"
      "Azure/kubelogin/kubelogin"
    ];

    casks = [
      "utm"
      "balenaetcher"
      "gimp"
      "raspberry-pi-imager"
    ];
  };

}
