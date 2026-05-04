{ pkgs, ... }:
{

  home.packages = with pkgs; [
    tmux
    fzf
    sesh
    fd
  ];

  programs.tmux = {
    enable = true;

    terminal = "screen-256color";
    mouse = false;
    keyMode = "vi";
    baseIndex = 1;
    clock24 = true;
    escapeTime = 10;
    prefix = "C-b";
    shell = "${pkgs.zsh}/bin/zsh";
    sensibleOnTop = true;

    plugins = with pkgs.tmuxPlugins; [
      tmux-fzf
      {
        plugin = tokyo-night-tmux;
        extraConfig = builtins.toString (builtins.readFile ./tmux-tokyonight.conf); # a // b to combine files
      }
    ];

    extraConfig = builtins.toString (builtins.readFile ./tmux.conf);
  };

}
