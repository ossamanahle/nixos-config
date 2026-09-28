{ config, pkgs, ... }:

{
  imports =
    [       
      ./hardware-configuration.nix
      ./desktop.nix
      ./dev.nix
      ./machine.nix
      ./users.nix
      ./network.nix
      ./other-pkgs.nix
    ];

  time.timeZone = "Europe/Nicosia";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [ "electron-41.10.7" ];
  
  system.stateVersion = "26.05";
  }
