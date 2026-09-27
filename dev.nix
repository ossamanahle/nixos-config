{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
  neovim
  bat
  atuin
  git
  tmux
  starship
  docker
  docker-compose
  devpod
  jq
  man 
  tldr 
  nodejs
  gcc
  pass
  claude-code
  pi-coding-agent
  tree-sitter
  unzip
  ];

  virtualisation.docker.enable = true;
}
