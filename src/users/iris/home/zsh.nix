{ ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      edit = "sudo -e";
      nix-update = "sudo nixos-rebuild switch";
    };

    initExtra = "export STARSHIP_CONFIG=~/.config/starship.toml";

  };
}
