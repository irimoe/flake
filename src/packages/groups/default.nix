{ pkgs, derivations }:
{
  imports = [
    (import ./base.nix { inherit pkgs; })
    (import ./desktop.nix { inherit pkgs derivations; })
    (import ./dev.nix { inherit pkgs derivations; })
    (import ./fonts.nix { inherit pkgs; })
  ];
}
