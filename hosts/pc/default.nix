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
    # efi = {
    #   canTouchEfiVariables = true;
    #   efiSysMountPoint = "/boot/efi"; # ← use the same mount point here.
    # };
    grub = {
      enable = true;
      device = "/dev/nvme0n2"; #  "nodev"
      efiSupport = false;
      useOSProber = true;
      #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
    };
  };

  services.printing.enable = true;
  networking.hostName = "nixos-pc";
  networking.networkmanager.enable = true;
  networking.wireless.enable = true;
  networking.firewall.enable = false;

  services = {
    udev.packages = with pkgs; [gnome-settings-daemon];
  };

  environment.systemPackages = with pkgs; [
  ];
}