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
        extraConfig = ''
          set -g @tokyo-night-tmux_theme storm
          set -g @tokyo-night-tmux_transparent 1
          set -g @tokyo-night-tmux_show_wbg 0
          set -g @tokyo-night-tmux_show_netspeed 0
          set -g @tokyo-night-tmux_netspeed_showip 0
          set -g @tokyo-night-tmux_netspeed_show 0
          set -g @tokyo-night-tmux_show_git 0
          set -g @tokyo-night-tmux_show_datetime 0
          set -g @tokyo-night-tmux_date_format MYD
          set -g @tokyo-night-tmux_time_format 12H
        '';
      }
    ];

    extraConfig = builtins.toString (builtins.readFile ./tmux.conf);
  };

}
