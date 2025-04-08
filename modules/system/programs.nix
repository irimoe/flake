{ ... }:

{
  programs = {
    firefox.enable = true;
    fish.enable = true;
    nix-ld.enable = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        ll = "ls -l";
        edit = "sudo -e";
        nix-update = "sudo nixos-rebuild switch";
      };
    };
  };
}