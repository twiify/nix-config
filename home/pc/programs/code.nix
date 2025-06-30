{config, pkgs, ...}:

{
  home.packages = with pkgs; [
    unstable.gnat15
    gnumake
    cmake
    unstable.xmake
    nodejs_24
    unstable.uv
    unstable.llvmPackages_20.clang-tools
  ];
}