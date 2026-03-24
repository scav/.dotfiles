{ ... }:

{

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap"; # remove unlisted brews/casks
      autoUpdate = true;
      upgrade = true;
    };

    casks = [
      "wootility"
    ];
  };

}
