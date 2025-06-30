{pkgs, profileName, ...}:

{
  imports = [
    ../../home/core.nix

    ../../home/${profileName}

  ];

  # Git 配置
  programs.git = {
    enable = true;
    userName = "Twiify";
    userEmail = "ppixiu07@gmail.com";
  };

  # Zsh 配置示例
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      ll = "ls -avhl";
      cls = "clear";
    };
  };


}