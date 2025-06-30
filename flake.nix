# flake.nix
{
  description = "A complete NixOS NAS configuration using Flakes and Home-Manager";

  inputs = {
    # NixOS 官方软件包集合，锁定在 25.05 稳定版
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs.url = "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixos-25.05/nixexprs.tar.xz";
    nixpkgs-unstable.url = "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixos-unstable/nixexprs.tar.xz";
    nixpkgs-stable.url = "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixos-25.05/nixexprs.tar.xz";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Home-Manager，用于管理用户家目录
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs"; # 确保 home-manager 使用和系统一致的 nixpkgs 版本
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      nixos-nas = let
        username = "oriontan"; # 修改为实际用户名
        profileName = "nas";
        specialArgs = {
          inherit username;
          inherit profileName;
        };
      in
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          inherit specialArgs;

          modules = [
            # 系统总入口
            ./hosts/${profileName}

            # 引入 home-manager 的 NixOS 模块
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              
              home-manager.extraSpecialArgs = inputs // specialArgs;
              home-manager.users.root = import ./users/${username}/root.nix;
              home-manager.users.${username} = import ./users/${username}/home.nix;
            }
          ];
        };
      
      nixos-pc = let
        username = "oriontan"; # 修改为实际用户名
        profileName = "pc";
        specialArgs = {
          inherit username;
          inherit profileName;
        };
      in
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          inherit specialArgs;

          modules = [
            # 系统总入口
            ./hosts/${profileName}

            # 引入 home-manager 的 NixOS 模块
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              
              home-manager.extraSpecialArgs = inputs // specialArgs;
              home-manager.users.root = import ./users/${username}/root.nix;
              home-manager.users.${username} = import ./users/${username}/home.nix;
            }
          ];
        };
    };
  };
}
