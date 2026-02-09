{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/mapper/luks-e9f5ff03-c8b6-47d3-bbb9-420375bef0c0";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-e9f5ff03-c8b6-47d3-bbb9-420375bef0c0".device =
    "/dev/disk/by-uuid/e9f5ff03-c8b6-47d3-bbb9-420375bef0c0";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/14BA-2AAA";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [ { device = "/dev/mapper/luks-8f8f3b09-4bb4-41cd-a925-ecd254314a28"; } ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
