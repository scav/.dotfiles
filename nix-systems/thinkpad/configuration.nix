{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/snx-rs.nix
    ../common-linux/configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Networking stuff
  networking.hostName = "thinkpad";
  networking.firewall.enable = true;
  networking.networkmanager = {
    enable = true;
    wifi.powersave = true;
  };

  programs.nm-applet = {
    enable = true;
    indicator = true;
  };

  time.timeZone = "Europe/Oslo";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocales = [
    "nb_NO.UTF-8/UTF-8"
  ];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # User
  users.users.scav = {
    enable = true;
    createHome = true;
    isNormalUser = true;
    description = "scav";
    initialPassword = "password";
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
    git
  ];
  hardware.firmware = with pkgs; [
    sof-firmware
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.neovim.defaultEditor = true;

  services = {
    auto-cpufreq.enable = true;
    auto-cpufreq.settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };

    fprintd.enable = true;

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd start-hyprland --remember";
          # command = "${config.programs.niri.package}/bin/niri-session";
          user = "scav";
        };
      };
    };

    openssh = {
      enable = true;
    };

    pcscd.enable = true;
    udev.packages = [ pkgs.yubikey-personalization ];

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    xserver.videoDrivers = [
      "nvidia"
      "modsettings"
    ];

  };

  programs.ssh = {
    startAgent = true;
    enableAskPassword = true;
  };

  # nvidia settings
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.nvidia = {
    open = true;
    powerManagement = {
      enable = true;
      finegrained = true;
    };
    modesetting.enable = true;
  };
  hardware.nvidia.prime = {
    intelBusId = "PCI:0@0:2:0";
    nvidiaBusId = "PCI:1@0:0:0";
    offload.enable = true;
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
  # hardware.keyboard.zsa.enable = true;

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

  system.stateVersion = "26.05";
}
