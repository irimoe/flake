{ pkgs, ... }:

{
  # Server-specific packages
  environment.systemPackages = with pkgs; [
    # Monitoring and maintenance
    htop
    iotop
    iftop
    ncdu
    tmux
    
    # Network tools
    mtr
    tcpdump
    iperf
    
    # System tools
    rsync
    curl
    wget
    vim
  ];

  # Server-specific services
  services = {
    # Example: Enable fail2ban
    fail2ban = {
      enable = true;
      maxretry = 5;
    };

    # Example: Enable automatic updates
    automatic-update = {
      enable = true;
      allowReboot = false;
    };
  };

  # Server security settings
  security = {
    sudo.wheelNeedsPassword = true;
    auditd.enable = true;
  };
}