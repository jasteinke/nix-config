{ config, lib, modulesPath, ... }:

{
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  boot.initrd.availableKernelModules = [ "uhci_hcd" "ehci_pci" "ahci" "firewire_ohci" "mptsas" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/mnt/backup" =
    { device = "/dev/disk/by-uuid/405afd75-0d2b-48f3-8c4f-b2250800ebf4";
      fsType = "btrfs";
      options = [ "compress=zstd" "nofail" ];
    };

  boot.initrd.luks.devices."backup".device = "/dev/disk/by-uuid/705d299c-1e67-472d-acb9-a970b8371eb8";

  zramSwap = {
    algorithm = "zstd";
    enable = true;
    memoryPercent = 240;
  };

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
