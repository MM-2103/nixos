{ config, lib, pkgs, ... }:
{
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"]; # or "nvidiaLegacy470 etc.

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;
    powerManagement.enable = true;
    open = true;

    prime = {
     offload = {
        enable = true;
        enableOffloadCmd = true;
     };
     intelBusId = "PCI:0:2:0";
     nvidiaBusId = "PCI:1:0:0";
    };
  };
}
