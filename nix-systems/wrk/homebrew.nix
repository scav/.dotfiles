{ ... }:

{

  homebrew = {
    enable = false;
    onActivation = {
      cleanup = "zap"; # remove unlisted brews/casks
      autoUpdate = true;
      upgrade = true;
    };

    casks = [
    ];
  };

}
