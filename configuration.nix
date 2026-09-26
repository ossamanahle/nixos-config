# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device =  "/dev/nvme0n1";
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

  # networking.hostName = "nixos"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Nicosia";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [ "electron-41.10.7" ];

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

  hardware.bluetooth.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";
  
  # My user:
  users.users.ossama = {
	isNormalUser = true;
	description = "ossama";
	extraGroups = [ "wheel" "docker" "networkmanager" ];
	shell = pkgs.zsh;
	home = "/home/ossama";
  };
  programs.zsh.enable = true;
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.autosuggestions.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  #services.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.alice = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     tree
  #   ];
  # };

  programs.firefox.enable = true;

  environment.sessionVariables = {
    HYPRCURSOR_THEME = "Simp1e-Gruvbox-Dark";
    HYPRCURSOR_SIZE = "24";
    XCURSOR_THEME = "Simp1e-Gruvbox-Dark";
    XCURSOR_SIZE = "24";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim
    neovim
    hyprland
    hypridle
    hyprlock
    grim
    slurp
    hyprpicker
    waybar
    yazi
    bat
    atuin
    mako
    fuzzel
    alacritty
    firefox
    git
    tmux
    firefox
    starship
    brightnessctl
    docker
    docker-compose
    devpod
    fastfetch
    jq
    man
    tldr
    nodejs
    gcc
    pass
    swaybg
    tailscale
    claude-code
    pi-coding-agent
    hyprcursor
    simp1e-cursors
    tree-sitter
    unzip
    wl-clipboard
    gnupg
    pinentry-curses
    zathura
    zathuraPkgs.zathura_pdf_mupdf
    libreoffice
    networkmanagerapplet
    bluez
    wireshark
    R
    rstudio
  ];

  services.tailscale.enable = true;

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  virtualisation.docker.enable = true;

  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts.jetbrains-mono
  ];


  fonts.fontconfig = {
    enable = true;
    defaultFonts =  {
      serif = [ "JetBrainsMono Nerd Font" ];
      sansSerif = [ " JetBrainsMono Nerd Font" ];
      monospace = [ " JetBrainsMono Nerd Font" ];
    };
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];

  security.polkit.enable =  true;
  security.pam.services.hyprlock = {};
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}

