{ pkgs, ... }:
let
  k9sTokyonight = pkgs.fetchFromGitHub {
    owner = "RickTimmer";
    repo = "k9s-tokyonight";
    rev = "develop";
    sha256 = "sha256-K7YjRnfsUxkGJnQG89Imd8amO0RAQTvxha+7GY4Ri4Y=";
  };
in
{
  programs.k9s = {
    enable = true;
    settings = {
      k9s = {
        readOnly = true;
        ui = {
          skin = "tokyonight";
        };
      };
    };
    skins = {
      tokyonight = "${k9sTokyonight}/skin.yml";
    };
    aliases = {
      dp = "deployments";
      sec = "v1/secrets";
      jo = "jobs";
      cr = "clusterroles";
      crb = "clusterrolebindings";
      ro = "roles";
      rb = "rolebindings";
      np = "networkpolicies";
      cnp = "cilium.io/v2/ciliumnetworkpolicies";
      ccp = "cilium.io/v2/ciliumclusterwidenetworkpolicies";
    };
  };
}
