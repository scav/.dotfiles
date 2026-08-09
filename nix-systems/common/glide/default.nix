{
  pkgs,
  ...
}:
{
  programs.glide-browser = {
    enable = true;
    nativeMessagingHosts = [ pkgs.keepassxc ];
  };
}
