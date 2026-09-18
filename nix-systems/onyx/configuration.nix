{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/gaming/gamma/default.nix
    ./modules/usenet.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-8f8f3b09-4bb4-41cd-a925-ecd254314a28".device =
    "/dev/disk/by-uuid/8f8f3b09-4bb4-41cd-a925-ecd254314a28";

  # Use zen-kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Networking stuff
  networking.hostName = "onyx";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  time.timeZone = "Europe/Oslo";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocales = [
    "nb_NO.UTF-8/UTF-8"
  ];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # User
  users.users.scav = {
    isNormalUser = true;
    description = "scav";
    extraGroups = [
      "networkmanager"
      "wheel"
      "podman"
      "libvirtd"
    ];
    packages = with pkgs; [
      dive
      podman-tui
      docker-compose
      podman-compose
    ];
  };

  # Allow unfree jackages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    rage
    ragenix
    age-plugin-yubikey
    git
    sbctl
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  programs.neovim.defaultEditor = true;

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  services = {
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd start-hyprland --remember";
          user = "greeter";
        };
      };
    };

    # RGB sucks
    hardware.openrgb = {
      enable = true;
    };

    jotta-cli.enable = true;

    #Slog generator
    ollama = {
      enable = true;
      package = pkgs.ollama-cuda;
    };

    openssh = {
      enable = true;
    };

    pcscd.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    xserver.videoDrivers = [ "nvidia" ];
  };

  programs.ssh = {
    startAgent = true;
  };

  # nvidia settings
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.nvidia = {
    open = true;
    powerManagement.enable = true;
  };

  # replace sudo
  security.sudo-rs = {
    enable = true;
    wheelNeedsPassword = true;
    execWheelOnly = true;
  };

  # Audio
  security.rtkit.enable = true;

  hardware.wooting.enable = true;
  hardware.keyboard.zsa.enable = true;

  programs.virt-manager.enable = true;

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  nix.settings = {
    substituters = [
      "https://cache.nixos-cuda.org"
      "https://scavpkgs.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      "scavpkgs.cachix.org-1:ZmnpP6suoyBvDXQN5DDjCV+azHNsXOugzVz90y9Bt8M="
    ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  system.stateVersion = "25.11";
}
