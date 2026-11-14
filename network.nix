{ pkgs, ... }: 

{
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;

  networking.extraHosts = ''
    192.168.10.240 jellyfin.home.lan
  '';

  environment.systemPackages = with pkgs; [
  tailscale
  bluez
  networkmanagerapplet
  ];

  services.tailscale.enable = true;
}
