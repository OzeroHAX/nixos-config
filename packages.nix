# Конфигурация пакетов и программ

{ config, lib, pkgs, ... }:

{
  # Разрешить несвободные пакеты
  nixpkgs.config.allowUnfree = true;

  # Системные пакеты
  environment.systemPackages = with pkgs; [
    # Терминал
    ghostty
    
    # Разработка
    git
    vscodium
    nodejs
    bun
    uv
    
    # Контейнеры
    docker-compose
    lazydocker
    distrobox
    
    # Десктоп
    google-chrome
    telegram-desktop
    libreoffice-qt
    
    # Утилиты
    throne
    xorg.xhost
    usbutils
    kdePackages.filelight
    host-spawn
  ];

  # Программы
  programs.nix-ld.enable = true;
  
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    
    promptInit = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };

  # Виртуализация
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true; 
  };
}
