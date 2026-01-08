{ ... }:

{

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap"; # remove unlisted brews/casks
      autoUpdate = true;
      upgrade = true;
    };

    taps = [
    ];

    brews = [
      "aws-sam-cli"
      "kiota"
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
