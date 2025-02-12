{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    grim
    slurp
    wl-clipboard
    mako
    foot
    fuzzel
  ];
}
