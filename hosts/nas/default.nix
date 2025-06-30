{config, pkgs, ...}:

{
  imports = [
    ../../modules/system.nix

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

  networking.hostName = "nixos-nas";
  networking.networkmanager.enable = true;
  networking.wireless.enable = true;
  networking.firewall.enable = true;

  services.printing.enable = false;


  environment.systemPackages = with pkgs; [

  ];

}