{ pkgs, ... }:
let
  derivations = import ./derivations/packages.nix { inherit pkgs; };
in
{
  imports = [
    (import ./groups { inherit pkgs derivations; })
  ];
}
