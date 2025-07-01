{pkgs, lib, inputs, username, ...}:

{
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    # 用户可以使用 sudo , 管理网络、docker 等
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    # 将 zsh 设置为默认 shell
    shell = pkgs.zsh;
  };

  nix.settings.trusted-users = [username];

  nix.settings = {
    # 启用 flakes
    experimental-features = [ "nix-command" "flakes" ];
    # 添加二进制缓存镜像
    substituters = [ 
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" 

      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  # 定时清理
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  nixpkgs.config = {
    # 允许闭源软件
    allowUnfree = true;
  };

  time.timeZone = "Asia/Shanghai";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "zh_CN.UTF-8";
  };

  programs.dconf.enable = true;
  programs.zsh.enable = true;

  # 字体设置
  fonts = {
    packages = with pkgs; [
      # icon fonts
      material-design-icons

      # normal fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji

      # nerdfonts
      # https://github.com/NixOS/nixpkgs/blob/nixos-unstable-small/pkgs/data/fonts/nerd-fonts/manifests/fonts.json
      nerd-fonts.symbols-only # symbols icon only
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka
    ];

    # use fonts specified by user rather than default ones
    enableDefaultPackages = false;

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig.defaultFonts = {
      serif = ["Noto Serif" "Noto Color Emoji"];
      sansSerif = ["Noto Sans" "Noto Color Emoji"];
      monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
  };

  # 启用 docker
  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs"; # or "zfs"
  };

  environment.systemPackages = with pkgs; [
    # 命令行工具
    wget
    curl
    git
    git-lfs
    htop
    neovim
    unzip
    sysstat
    fastfetch
    pciutils # lspci
    usbutils # lsusb
    lshw

    efibootmgr
    btrfs-progs
    nnn
    smartmontools # 硬盘健康监控
    docker-compose # 动态管理 docker compose
  ];

  services.pulseaudio.enable = false;
  services.power-profiles-daemon = {
    enable = true;
  };
  security.polkit.enable = true;

  services.cron.enable = true;

  services = {
    dbus.packages = [pkgs.gcr];

    geoclue2.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # 使用 JACK 取消注释
      jack.enable = true;

      # 使用示例会话管理器（目前没有其他会话管理器打包，因此默认启用，
      # 目前无需在配置中重新定义）
      #media-session.enable = true;
    };
  };

}