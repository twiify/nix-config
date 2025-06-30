{config, pkgs, ...}:

{
  home.packages = with pkgs; [
    google-chrome
    kitty
    vscode
  ]; 
}