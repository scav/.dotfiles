{
  pkgs,
  ...
}:
{
  imports = [
    ./nix-systems/common/tmux.nix
  ];

  home.sessionVariables = {
    MANPAGER = "nvim +Man!";
    MANWIDTH = "999";
  };

  programs.home-manager.enable = true;
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    gnumake
    act
    fzf
    (pkgs.nix-search-tv.overrideAttrs (old: {
      env = (old.env or { }) // {
        GOEXPERIMENT = "jsonv2";
      };

      installPhase = (old.installPhase or "") + ''
        install -Dm755 nixpkgs.sh $out/bin/ns
      '';
    }))
  ];
}
