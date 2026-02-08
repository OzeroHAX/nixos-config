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
    python3
    
    # Контейнеры
    docker-compose
    lazydocker
    distrobox
    
    # Десктоп
    google-chrome
    telegram-desktop
    libreoffice-qt
    vlc
    
    # Утилиты
    ripgrep
    throne
    xorg.xhost
    usbutils
    kdePackages.filelight
    host-spawn
    appimage-run
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

  # Ollama - локальный LLM сервер с GPU ускорением
  services.ollama = {
    enable = true;
    acceleration = "rocm";
  };

  systemd.services.ollama.environment = {
    # Parallel embedding requests (increase to match GPU capacity)
    OLLAMA_NUM_PARALLEL = "4";
    # Keep model in memory between requests
    OLLAMA_KEEP_ALIVE = "10m";
    # Limit number of models loaded at once
    OLLAMA_MAX_LOADED_MODELS = "1";
  };
}
