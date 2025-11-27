{ ... }:

{

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap"; # remove unlisted brews/casks
      # cleanup = "uninstall"; # remove unlisted brews/casks
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
      "helm"
      "kiota"
      "make"
      "mockery"
      "whalebrew"
    ];

    casks = [
      "balenaetcher"
      "gimp"
      "ghostty"
      "raspberry-pi-imager"
      "wootility"
    ];
  };

}
