{ pkgs, ... }:

{
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
}
