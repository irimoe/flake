{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wget
    curl
    vim
    git
    killall
    file
    unzip
    jq
    htop
    tmux
    gnupg
    libsecret
    gnome-keyring
    just
  ];
}
