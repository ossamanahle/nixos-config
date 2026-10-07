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
  awscli2
  ssm-session-manager-plugin
  ];

  virtualisation.docker.enable = true;
}
