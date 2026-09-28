{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wireshark
    R
    rstudio
    obsidian
  ];
}
