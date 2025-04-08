{ pkgs }:
{
  bun = pkgs.callPackage ./bun.nix { };
  zed-editor = pkgs.callPackage ./zed-editor.nix { };
  zed-preview = pkgs.callPackage ./zed-editor-preview.nix { };
  zen-browser = pkgs.callPackage ./zen-browser.nix { };
}
