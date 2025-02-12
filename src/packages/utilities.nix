{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    htop
    wget
    vim
    git
    zsh
    gnome-keyring
    libsecret
    just
    tmux
  ];
}
