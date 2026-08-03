{ pkgs, ... }:
{
  stylix.targets.k9s = {
    enable = true;
    colors.enable = true;
  };

  programs.k9s = {
    enable = true;
    settings = {
      k9s = {
        readOnly = true;
      };
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
