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
  direnv
  cargo
  pass
  claude-code
  pi-coding-agent
  opencode
  tree-sitter
  unzip
  awscli2
  ssm-session-manager-plugin
  stow
  ];

  virtualisation.docker.enable = true;
  programs.ssh.startAgent = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  
  services.keyd = {
    enable = true;

    keyboards.default = {
      ids = [ "*" ];

      settings = {
        main = {
          capslock = "leftcontrol";
          leftcontrol = "capslock";
        };
      };
    };
  };
}
