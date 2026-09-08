{ config, pkgs, ... }:

{
  # imports = [
  #   ./hardware-configuration.nix
  # ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking stuff
  networking.hostName = "thinkpad";
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
  };

  # Allow unfree jackages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.neovim.defaultEditor = true;

  services = {
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

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # xserver.videoDrivers = [ "nvidia" ];
  };

  programs.ssh = {
    startAgent = true;
  };

  # nvidia settings
  hardware.graphics = {
    enable = true;
    # enable32Bit = true;
  };
  # hardware.nvidia = {
  #   open = true;
  #   powerManagement.enable = true;
  # };
  virtualisation.vmVariant = {
    virtualisation.qemu.options = [
      "-device virtio-vga-gl"
      "-display gtk,gl=on"
    ];
  };
  services.xserver.videoDrivers = [ "modesetting" ];

  # replace sudo
  security.sudo-rs = {
    enable = true;
    wheelNeedsPassword = true;
    execWheelOnly = true;
  };

  # Audio
  security.rtkit.enable = true;

  # hardware.wooting.enable = true;
  # hardware.keyboard.zsa.enable = true;

  # programs.virt-manager.enable = true;
  # virtualisation = {
  #   libvirtd = {
  #     enable = true;
  #     qemu = {
  #       package = pkgs.qemu_kvm;
  #       runAsRoot = true;
  #       swtpm.enable = true;
  #     };
  #   };
  #   containers.enable = true;
  #   podman = {
  #     enable = true;
  #     dockerCompat = true;
  #     defaultNetwork.settings.dns_enabled = true;
  #   };
  # };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  system.stateVersion = "26.05";
}
