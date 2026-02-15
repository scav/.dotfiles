{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    television
    fd
    zoxide
  ];

  programs.television = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      tick_rate = 120;
      default_channel = "files";
      use_nerd_font_icons = true;
    };
    channels = {

      sesh = {
        metadata = {
          name = "sesh";
          description = "Session manager integrating tmux sessions, zoxide directories, and config paths";
          requirements = [
            "sesh"
            "fd"
          ];
        };

        source = {
          command = [
            "sesh list --icons"
            "sesh list -t --icons"
            "sesh list -c --icons"
            "sesh list -z --icons"
            "fd -H -d 2 -t d -E .Trash . ~"
          ];
          ansi = true;
          output = "{strip_ansi|split: :1..|join: }";
        };

        preview = {
          command = "sesh preview '{strip_ansi|split: :1..|join: }'";
        };

        keybindings = {
          enter = "actions:connect";
          "ctrl-d" = [
            "actions:kill_session"
            "reload_source"
          ];
        };

        actions = {
          connect = {
            description = "Connect to selected session";
            command = "sesh connect '{strip_ansi|split: :1..|join: }'";
            mode = "execute";
          };

          kill_session = {
            description = "Kill selected tmux session (press Ctrl+r to reload)";
            command = "tmux kill-session -t '{strip_ansi|split: :1..|join: }'";
            mode = "fork";
          };
        };
      };
    };
  };
}
