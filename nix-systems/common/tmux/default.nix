{ pkgs, config, ... }:
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

    extraConfig = builtins.readFile ./tmux.conf + ''
      # Use Stylix Base16 colors for the status bar
      set -g status-style "bg=#${config.lib.stylix.colors.base00},fg=#${config.lib.stylix.colors.base05}"

      # Highlight active window using accent colors
      setw -g window-status-current-style "bg=#${config.lib.stylix.colors.base0D},fg=#${config.lib.stylix.colors.base01}"
      setw -g window-status-style "bg=#${config.lib.stylix.colors.base01},fg=#${config.lib.stylix.colors.base04}"

      # Style pane borders
      set -g pane-border-style "fg=#${config.lib.stylix.colors.base02}"
      set -g pane-active-border-style "fg=#${config.lib.stylix.colors.base0D}"
    '';
  };
}
