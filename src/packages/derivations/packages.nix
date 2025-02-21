{ pkgs }:
{
  bun = pkgs.callPackage ./bun.nix { };
  zed-editor = pkgs.callPackage ./zed-editor.nix { };
}
