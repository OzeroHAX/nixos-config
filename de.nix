# Конфигурация Desktop Environment (Plasma 6)

{ config, lib, pkgs, ... }:

{
  # Display Manager
  services.displayManager.sddm.enable = true;
  
  # Desktop Environment
  services.desktopManager.plasma6.enable = true;
  
  # Исключения из Plasma 6
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    konsole
    kate
    khelpcenter
  ];
}
