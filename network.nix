{ pkgs, ... }: 

{
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;

  environment.systemPackages = with pkgs; [
  tailscale
  bluez
  networkmanagerapplet
  ];

  services.tailscale.enable = true;
}
