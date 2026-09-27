{ config, pkgs, ... }: 

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device =  "/dev/nvme0n1";
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];

  # Swap: 8 GB file on / plus compressed RAM swap (zram).
  # zram gets higher priority automatically, so the disk file is a last resort.
  swapDevices = [
    { device = "/swapfile"; size = 8 * 1024; } # size in MiB
  ];

  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  # Only swap under real memory pressure.
  boot.kernel.sysctl."vm.swappiness" = 10;

  # Enable graphics stack
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  # Nvidia driver setup for hybrid
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
