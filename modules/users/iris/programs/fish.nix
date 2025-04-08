{ ... }:

{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''set fish_greeting '';
    shellAliases = {
      ll = "ls -l";
      edit = "sudo -e";
      nix-update = "sudo nixos-rebuild switch";
    };
  };
}
