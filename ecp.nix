# Конфигурация для работы с ЭЦП (электронная цифровая подпись)
# нужно тем, кто работает с КриптоПро и тд
# USB токен: idVendor=0a89, idProduct=0025

{ config, lib, pkgs, ... }:

{
  # udev правила для доступа к USB токену ЭЦП
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="0a89", ATTR{idProduct}=="0025", MODE="0666", TAG+="uaccess"
  '';
}
