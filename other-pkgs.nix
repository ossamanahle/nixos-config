{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    R
    rstudio
    obsidian
  ];

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark; # default is wireshark-cli (no GUI)
  };
}
