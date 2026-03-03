
{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./ecp.nix
      ./packages.nix
      ./de.nix
      ./gaming.nix
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    kernelModules = [ "v4l2loopback" ];
    extraModprobeConfig = ''
      options v4l2loopback devices=2 video_nr=2,3 card_label="iPhone Cam 1,iPhone Cam 2" exclusive_caps=1,1
    '';
  };

  networking = {
    hostName = "laptopmax";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [ 8080 ];
  };

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";
  
  hardware.graphics = {
    enable = true;

    package = pkgs.libglvnd;
    package32 = pkgs.pkgsi686Linux.libglvnd;

    extraPackages = with pkgs; [
      mesa
      rocmPackages.clr.icd
    ];

    extraPackages32 = with pkgs.pkgsi686Linux; [
      mesa
    ];
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  security.sudo.wheelNeedsPassword = true;  

  users.users.maxim = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "podman" "video" ];
    shell = pkgs.zsh;
  };

  system.stateVersion = "25.11";

}
