{config, pkgs, ...}:

{
  imports = [
    ../../modules/system.nix
    ../../modules/kde.nix

    ./hardware-configuration.nix
  ];

  system.stateVersion = "25.05";

  # Bootloader
  boot.loader = {
    timeout = 10;
    systemd-boot.enable = false;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot"; # ← use the same mount point here.
    };
    grub = {
      enable = true;
      device = "nodev"; #  "nodev"
      efiSupport = true;
      useOSProber = true;
      # efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system

      theme = pkgs.sleek-grub-theme.override {
        withBanner = "Grub Bootloader";
        withStyle = "dark";
      };
    };
    
  };

  services.printing.enable = true;
  networking.hostName = "nixos-pc";
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;
  networking.firewall.enable = false;

  # services = {
  #   udev.packages = with pkgs; [gnome-settings-daemon];
  # };

  environment.systemPackages = with pkgs; [
  ];
}