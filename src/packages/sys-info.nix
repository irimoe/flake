{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ neofetch fastfetch kittysay ];
}
