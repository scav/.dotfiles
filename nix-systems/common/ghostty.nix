{ pkgs, lib, ... }:

let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
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
