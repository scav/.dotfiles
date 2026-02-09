{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    tokyonight-gtk-theme
  ];

  home.pointerCursor = {
    hyprcursor = {
      size = 64;
      enable = true;
    };
    name = "Nordzy-hyprcursors-white";
    package = pkgs.nordzy-cursor-theme;
  };

  gtk = {
    enable = true;

    # GTK theme
    theme = {
      name = "Tokyonight-Dark";
      package = pkgs.tokyonight-gtk-theme;
    };

    # optional: icon theme
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    # optional: cursor theme
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };

    # enable extra gtk config if you want
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
}
