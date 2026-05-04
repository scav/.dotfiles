{ pkgs, ... }:

let
  location = "games";
in
{

  users.users.scav.packages = with pkgs; [
    protontricks
    gamma-launcher
  ];

  environment.systemPackages = [
    (pkgs.writeShellApplication {
      name = "gamma-installer";
      runtimeInputs = [
        pkgs.gamma-launcher
      ];
      text = ''
        gamma-launcher full-install \
          --anomaly "$HOME/${location}/STALKER/ANOMALY" \
          --gamma "$HOME/${location}/STALKER/GAMMA" \
          --cache-directory "$HOME/${location}/STALKER/gamma-launcher-cache"
      '';
    })
  ];
}
