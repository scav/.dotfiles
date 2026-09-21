{ pkgs, config, ... }:

let
  c = config.lib.stylix.colors.withHashtag;
in
{
  stylix.targets.rofi.enable = false;

  programs.rofi = {
    enable = true;
    terminal = "uwsm app -- ${pkgs.ghostty}/bin/ghostty";

    extraConfig = {
      modi = [
        "drun"
        "window"
        "run"
      ];
      icon-theme = "Papirus-Dark";
      show-icons = true;
      drun-display-format = "{icon} {name}";
      location = 0;
      disable-history = false;
      sidebar-mode = false;

      display-drun = " ";
      display-run = " ";
      display-window = " ";

      drun-launch = "uwsm app -- {cmd}";
      run-command = "uwsm app -- {cmd}";

      # Vim keybindings
      kb-row-up = "Up,Control+k";
      kb-row-left = "Left,Control+h";
      kb-row-right = "Right,Control+l";
      kb-row-down = "Down,Control+j";
      kb-accept-entry = "Control+z,Control+y,Return,KP_Enter";

      # Navigation fixes
      kb-remove-to-eol = "";
      kb-move-char-back = "Control+b";
      kb-remove-char-back = "BackSpace";
      kb-move-char-forward = "Control+f";
      kb-mode-complete = "Control+o";
    };

    # use stylix theming
    theme = "${pkgs.writeText "rofi-theme.rasi" ''
      * {
          bg: ${c.base00};
          primary: ${c.base0D};
          hv: ${c.base0E};
          kl: ${c.base05};
          wn: ${c.base0F};
          black: #000000;
          transparent: rgba(0, 0, 0, 0);

          background-color: @bg;
          border: 0px;
      }

      window {
          width: 700px;
          orientation: horizontal;
          location: center;
          anchor: center;
          transparency: "screenshot";
          border-color: @transparent;   
          border: 0px;
          border-radius: 6px;
          spacing: 0;
          children: [ mainbox ];
      }

      mainbox {
          spacing: 0;
          children: [ inputbar, message, listview ];
      }

      inputbar {
          color: @kl;
          padding: 11px;
          border: 1px 1px 1px 1px;
          border-color: @primary;
          border-radius: 6px 6px 0px 0px;
      }

      message {
          padding: 0;
          border-color: @primary;
          border: 0px 1px 1px 1px;
      }
      textbox {
          color: @wn;
          padding: 0;
      }

      entry, prompt, case-indicator {
          text-font: inherit;
          text-color: inherit;
      }

      entry {
          cursor: pointer;
      }

      prompt {
          margin: 0px 5px 0px 0px;
      }

      listview {
          layout: vertical;
          padding: 8px;
          lines: 7;
          columns: 2;
          border: 0px 1px 1px 1px;
          border-radius: 0px 0px 6px 6px;
          border-color: @primary;
          dynamic: false;
      }

      element {
          padding: 2px;
          vertical-align: 1;
          color: @kl;
          font: inherit;
      }

      element-text {
          background-color: inherit;
          text-color: inherit;
          vertical-align: 0.5;
      }

      element selected.normal {
          color: @black;
          background-color: @hv;
      }

      element normal active {
          background-color: @hv;
          color: @black;
      }

      element-icon {
          background-color: inherit;
          text-color: inherit;
          size: 2.5em;
      }

      element normal urgent {
          background-color: @primary;
      }

      element selected active {
          background: @hv;
          foreground: @bg;
      }

      button {
          padding: 6px;
          color: @primary;
          horizontal-align: 0.5;
          border: 2px 0px 2px 2px;
          border-radius: 4px 0px 0px 4px;
          border-color: @primary;
      }

      button selected normal {
          border: 2px 0px 2px 2px;
          border-color: @primary;
      }
    ''}";
  };
}
