{ pkgs, ... }:
let
  theme = ''
    listview { fixed-height: 0; margin: 0; padding: 0; border: 0; lines: 0; }
  '';

  rofi-askpass = pkgs.writeShellScriptBin "rofi-askpass" ''
    exec ${pkgs.rofi}/bin/rofi \
    -dmenu \
    -password -p " " \
    -mesg "$1" \
    -theme-str '${theme}'
  '';
in
{
  programs.ssh = {
    startAgent = true;
    enableAskPassword = true;
    askPassword = "${rofi-askpass}/bin/rofi-askpass";
  };

  users.users.scav = {
    packages = with pkgs; [
      grim
      slurp
    ];
  };
}
