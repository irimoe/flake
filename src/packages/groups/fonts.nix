{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono

    jetbrains-mono
    noto-fonts-color-emoji
    noto-fonts
  ];
}
