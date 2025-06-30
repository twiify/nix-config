{config, pkgs, unstable, ...}:

{
  home.packages = with pkgs; [
    gnumake
    cmake
    nodejs_24
    unstable.xmake
    unstable.ninja
    unstable.gnat15
    unstable.uv
    unstable.clang_20
    unstable.llvmPackages_20.clang-tools
  ];
}