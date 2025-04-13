{
  pkgs ? import <nixpkgs> { },
}:

{
  bun = import ./bun.nix { inherit pkgs; };
  zed-editor = import ./zed-editor.nix { inherit pkgs; };
  zed-editor-preview = import ./zed-editor-preview.nix { inherit pkgs; };
  zen-browser = import ./zen-browser.nix { inherit pkgs; };
  sylph = import ./sylph.nix { inherit pkgs; };

  inherit (import ./packages.nix { inherit pkgs; }) bunFinal zedEditor zenBrowser;
}
