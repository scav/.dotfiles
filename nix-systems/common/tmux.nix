{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    terminal = "screen-256color";
    mouse = true;
    keyMode = "vi";
    baseIndex = 1;
    paneBaseIndex = 1;
    clock24 = true;

    home.packages = with pkgs; [
      tmux
      fzf
      sesh
      fd
    ];

    plugins = with pkgs.tmuxPlugins; [
      tmux-fzf
      # add themes/plugins here if you want later
      # tokyo-night-tmux
      tmux2k
    ];

    extraConfig = ''
      # reload config
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf

      set -g display-time 4000
      set -g status-interval 1
      set -g focus-events on
      set -g status-position top

      # status bar
      set -g status on
      setw -g monitor-activity on

      # leader
      set -g prefix C-b
      unbind C-b
      bind C-b send-prefix

      bind t new-window

      # Close pane with confirmation
      bind x confirm-before -p "kill-pane? (y/n)" kill-pane

      # splits
      bind - split-window -v
      bind = split-window -h

      # navigate panes
      bind -n C-h select-pane -L
      bind -n C-j select-pane -D
      bind -n C-k select-pane -U
      bind -n C-l select-pane -R

      bind -n C-p previous-window
      bind -n C-n next-window

      # resize panes
      bind -n M-h resize-pane -L 1
      bind -n M-j resize-pane -D 1
      bind -n M-k resize-pane -U 1
      bind -n M-l resize-pane -R 1
      bind -n M-H resize-pane -L 10
      bind -n M-J resize-pane -D 10
      bind -n M-K resize-pane -U 10
      bind -n M-L resize-pane -R 10

      # sesh session switcher
      bind-key s run-shell "sesh connect \"\$(
        sesh list --icons | fzf-tmux -p 80%,70% \
          --no-sort --ansi --border-label ' sessions ' --prompt '⚡  ' \
          --header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
          --bind 'tab:down,btab:up' \
          --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
          --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)' \
          --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)' \
          --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)' \
          --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
          --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)' \
          --preview-window 'right:55%' \
          --preview 'sesh preview {}'
      )\""
    '';
  };

}
