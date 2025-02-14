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

    initExtra = ''
      export STARSHIP_CONFIG=~/.config/starship.toml

      function zle-line-init zle-keymap-select {
          RPROMPT='%F{blue}%B%D{%H:%M:%S}%b%f'
          zle reset-prompt
      }
      zle -N zle-line-init
      zle -N zle-keymap-select

      TMOUT=1
      TRAPALRM() {
          RPROMPT='%F{blue}%B%D{%H:%M:%S}%b%f'
          zle reset-prompt
      }

    '';

  };
}
