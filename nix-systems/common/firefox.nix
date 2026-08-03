{ pkgs, config, ... }:
{
  stylix.targets.firefox = {
    enable = true;
    fonts.enable = true;
    colors.enable = true;
    firefoxGnomeTheme.enable = false;
    colorTheme.enable = true;
    profileNames = [ "scav" ];
  };

  programs.firefox = {
    enable = true;
    profiles = {
      "scav" = {
        id = 0;
        extensions = {
          force = true;
        };
        settings = {
          "browser.aboutConfig.showWarning" = false;
          "layout.css.prefers-color-scheme.content-override" = 0;
          "browser.theme.toolbar-theme" = 2;
          "browser.theme.content-theme" = 2;
        };
      };
    };
  };
}
