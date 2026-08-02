{ pkgs, ... }:

let
  location = "games";
in
{
  nixpkgs.overlays = [
    (final: prev: {
      python3Packages = prev.python3Packages.override {
        overrides = pSelf: pSuper: {
          python-unrar = pSuper.python-unrar.overrideAttrs (_: {
            dontCheckPythonMetadata = true;
          });
        };
      };
    })
  ];

  users.users.scav.packages = [
    pkgs.protontricks
    pkgs.gamma-launcher
  ];

  environment.systemPackages = [
    # gamma-installer is also used to check for updates
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
    (pkgs.writeShellApplication {
      name = "gamma-check-anomaly";
      runtimeInputs = [
        pkgs.gamma-launcher
      ];
      text = ''
        gamma-launcher check-anomaly \
          --anomaly "$HOME/${location}/STALKER/ANOMALY"
      '';
    })
    (pkgs.writeShellApplication {
      name = "gamma-check-md5";
      runtimeInputs = [
        pkgs.gamma-launcher
      ];
      text = ''
        gamma-launcher check-md5 \
          --gamma "$HOME/${location}/STALKER/GAMMA"
      '';
    })
  ];
}
