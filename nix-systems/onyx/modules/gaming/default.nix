{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.starsector
  ];

  programs.discord = {
    enable = true;
    settings.SKIP_HOST_UPDATE = true;
  };

  programs.lutris = {
    enable = true;
    package = pkgs.lutris.override {
      lutris-unwrapped = pkgs.lutris-unwrapped.overrideAttrs (old: {
        postPatch = (old.postPatch or "") + ''
          substituteInPlace lutris/util/display.py \
            --replace-fail "if LIB_GNOME_DESKTOP_AVAILABLE:" "if False:"
        '';
      });
    };
  };
}
