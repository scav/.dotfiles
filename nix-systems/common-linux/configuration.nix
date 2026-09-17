{ pkgs, ... }:

{
  users.users.scav = {
    packages = with pkgs; [
      grim
      slurp
    ];
  };
}
