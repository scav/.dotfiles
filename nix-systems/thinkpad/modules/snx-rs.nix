{ pkgs, ... }:
{
  # (define snx-rs.conf
  #   (plain-file "snx-rs-conf"
  #               "server-name=bridge2.tv2.no
  # login-type=vpn_cp-cert
  # default-route=true
  # tunnel-type=ipsec
  # ike-persist=true
  # "))
  environment.systemPackages = with pkgs; [
    snx-rs
  ];
  systemd.services.snx-rs = {
    enable = true;
    description = "SNX-RS VPN client for Linux";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.snx-rs}/bin/snx-rs -m command -l debug";
      Type = "simple";
    };
  };

  # update the firewall rule to allow keepalive traffic
  networking.firewall.checkReversePath = "loose";
}
