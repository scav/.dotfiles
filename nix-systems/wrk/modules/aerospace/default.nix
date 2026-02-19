{ ... }:
{
  programs.aerospace = {
    enable = true;
    launchd = {
      enable = true;
      keepAlive = true;
    };
    settings = {
      start-at-login = false;
      gaps = {
        outer.left = 1;
        outer.bottom = 1;
        outer.top = 1;
        outer.right = 1;
      };
      # key-mapping = {
      #   present = "qwerty";
      # };
      mode.main.binding = {
        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";

        # Navigate workspaces
        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";

        # Move windows
        alt-shift-1 = "move-node-to-workspace 1";
        alt-shift-2 = "move-node-to-workspace 2";
        alt-shift-3 = "move-node-to-workspace 3";
      };
    };
  };
}
