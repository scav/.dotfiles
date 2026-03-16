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
    ];

    casks = [
      "balenaetcher"
      "gimp"
      "raspberry-pi-imager"
      "wootility"
    ];
  };

}
