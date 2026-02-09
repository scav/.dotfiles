{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-8f8f3b09-4bb4-41cd-a925-ecd254314a28".device =
    "/dev/disk/by-uuid/8f8f3b09-4bb4-41cd-a925-ecd254314a28";

  # Networking stuff
  networking.hostName = "onyx"; # Define your hostname.
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  time.timeZone = "Europe/Oslo";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocales = [
    "nb_NO.UTF-8/UTF-8"
  ];

  # User
  users.users.scav = {
    isNormalUser = true;
    description = "scav";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [ ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    sbctl
    wget
    foot
    waybar
    hyprpaper
    ghostty
    tmux
    neovim
    keymapp
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  programs.firefox.enable = true;

  services.displayManager.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  programs.neovim.defaultEditor = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.ssh = {
    startAgent = true;
  };

  # nvidia settings
  hardware.graphics.enable = true;
  hardware.nvidia = {
    open = true;
    powerManagement.enable = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.xkb.options = "compose:ralt";

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  hardware.wooting.enable = true;
  hardware.keyboard.zsa.enable = true;

  # Flake and version
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "25.11";
}
