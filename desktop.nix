{ pkgs, ... }: 

{
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";

  environment.systemPackages = with pkgs; [
  hyprland
  hypridle
  hyprlock
  waybar
  mako
  fuzzel
  yazi
  swaybg
  hyprcursor
  simp1e-cursors
  grim
  slurp
  hyprpicker
  wl-clipboard
  zathura
  zathuraPkgs.zathura_pdf_mupdf
  libreoffice
  alacritty
  firefox
  brightnessctl
  fastfetch
  gnupg
  pinentry-curses
  ];

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

  programs.firefox.enable = true;

  environment.sessionVariables = {
    HYPRCURSOR_THEME = "Simp1e-Gruvbox-Dark";
    HYPRCURSOR_SIZE = "24";
    XCURSOR_THEME = "Simp1e-Gruvbox-Dark";
    XCURSOR_SIZE = "24";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };
}
