{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fzf
    sesh
    fd
  ];

  stylix.targets.tmux = {
    enable = true;
    inputs.enable = true;
  };

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
    ];

    extraConfig = builtins.toString (builtins.readFile ./tmux.conf);
  };
}
