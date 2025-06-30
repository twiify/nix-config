# root 用户的 Home-Manager 配置
{ pkgs, ... }:
{
  home.stateVersion = "25.05";
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -avhl";
    };
  };
}
