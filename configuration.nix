
{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./ecp.nix
      ./packages.nix
      ./de.nix
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking = {
    hostName = "laptopmax";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";
  
  hardware = {
    nvidia-container-toolkit.enable = true;
    nvidia = {
      modesetting.enable = true;
      open = false;
    };
    graphics.enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  security.sudo.wheelNeedsPassword = true;  

  users.users.maxim = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "podman" ];
    shell = pkgs.zsh;
  };

  system.stateVersion = "25.11";

}

