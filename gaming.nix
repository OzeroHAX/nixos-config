# Конфигурация игр и записи

{ config, pkgs, ... }:

{
  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  # 32-bit поддержка для игр
  hardware.graphics = {
    enable32Bit = true;
  };

  # Улучшение производительности игр
  programs.gamemode.enable = true;
}
