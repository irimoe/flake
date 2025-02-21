{ ... }:

{
  imports = [
    ./zsh.nix
  ];

  programs = {
    firefox.enable = true;
    zsh.enable = true;
    fish.enable = true;
    nix-ld.enable = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
