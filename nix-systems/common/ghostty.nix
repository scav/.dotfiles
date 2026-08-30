{ pkgs, lib, ... }:

let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;

  ghostty-cursors = pkgs.fetchFromGitHub {
    owner = "sahaj-b";
    repo = "ghostty-cursor-shaders";
    rev = "main";
    sha256 = "sha256-B7B6K7Ee4uJlW8zzLP3ILgddnbcIQyNimY+rVllzbR0=";
  };
in
{
  programs.ghostty = {
    enable = true;
    package = if isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
    enableZshIntegration = true;
    settings = {
      title = "";
      window-decoration = false;

      font-feature = [
        "+calt"
        "+liga"
      ];

      shell-integration = "zsh";
      shell-integration-features = [
        "sudo"
        "ssh-terminfo"
      ];

      mouse-hide-while-typing = true;
      confirm-close-surface = false;
      right-click-action = "ignore";
      custom-shader = [
        "${ghostty-cursors}/cursor_warp.glsl"
        "${ghostty-cursors}/sonic_boom_cursor.glsl"
      ];

    }
    # macOS specific settings merged only on macOS
    // lib.optionalAttrs isDarwin {
      macos-option-as-alt = true;
      macos-titlebar-style = "hidden";
    };
  };

  stylix.targets.ghostty = {
    enable = true;
  };
}
