{
  pkgs,
  ...
}:
{
  programs.home-manager.enable = true;
  home.stateVersion = "26.05";

  hom.packages = with pkgs; [
    gnumake
  ];
}
