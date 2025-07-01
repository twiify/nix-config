{pkgs, profileName, ...}:

{
  imports = [
    ../../home/core.nix

    ../../home/${profileName}

  ];

  # Git 配置
  programs.git = {
    enable = true;
    lfs.enable = true;
    config = {
      init = {
        defaultBranch = "main";
      };
    };
    userName = "Twiify";
    userEmail = "ppixiu07@gmail.com";
  };

  # Zsh 配置示例
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -avhl";
      cls = "clear";
      umount = "umount -v";
      chmod = "chmod -v";
      chown = "chown -v";
      cp = "cp -v";
      mv = "mv -v";
      rm = "rm -v";
      rmdir = "rmdir -v";
      mkdir = "mkdir -pv";
    };

    history.size = 10000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    history.ignorePatterns = ["rm *" "pkill *" "cp *"];

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"  # also requires `programs.git.enable = true;`
      ];
      theme = "wuffers";
    };
  };

}