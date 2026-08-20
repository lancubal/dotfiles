# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # ================================================================
  # BOOTLOADER (GRUB UEFI con Submenús)
  # ================================================================
  # 1. Desactivamos systemd-boot
  boot.loader.systemd-boot.enable = false;

  # 2. Habilitamos soporte para modificar variables EFI
  boot.loader.efi.canTouchEfiVariables = true;
  # Opcional: Define dónde está tu partición EFI si NixOS te tira error
  boot.loader.efi.efiSysMountPoint = "/boot/efi"; 

  # 3. Configuramos GRUB
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";          # En UEFI siempre debe ser "nodev"
    useOSProber = true;        # CRÍTICO: Para que detecte Windows automáticamente
    configurationLimit = 10;   # Mantén un límite para que el submenú no sea eterno
  };

  boot.loader.timeout = null;

  # Activar el Recolector de Basura automático
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  
  # Optimizar el almacenamiento (Hardlinking de archivos duplicados)
  nix.settings.auto-optimise-store = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Argentina/Buenos_Aires";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_AR.UTF-8";
    LC_IDENTIFICATION = "es_AR.UTF-8";
    LC_MEASUREMENT = "es_AR.UTF-8";
    LC_MONETARY = "es_AR.UTF-8";
    LC_NAME = "es_AR.UTF-8";
    LC_NUMERIC = "es_AR.UTF-8";
    LC_PAPER = "es_AR.UTF-8";
    LC_TELEPHONE = "es_AR.UTF-8";
    LC_TIME = "es_AR.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Cinnamon Desktop Environment.
  # services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  programs.nix-ld.enable = true;
  environment.localBinInPath = true;

  # Habilitar Shell Fish y Starship Prompt
  programs.fish.enable = true;
  programs.starship.enable = true;

  # Configuración de Fuentes (MesloLGM Nerd Font)
  fonts.packages = with pkgs; [
    nerd-fonts.meslo-lg
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."luna" = {
    isNormalUser = true;
    description = "Luna Lancuba";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.fish;
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   git vim wget
   ntfs3g
   mergerfs
   pass
   obsidian
   unzip
   p7zip
   gnupg
   pinentry-curses
   vscode 
   tidal-hifi
   nodejs 
   (python3.withPackages (ps: with ps; [ pip ]))
   docker-compose
   wireshark
   gcc
   neovim
   ripgrep
   fd
   gnumake
   cmake
   clang-tools
   jdk
   marksman
   google-java-format
   prettier
   stylua
   pulsemixer
   libnotify
   luarocks
   lua5_1
   mercurial
   go
   tor-browser
   cargo
   rustc
   tree-sitter
   ruby
   php
   phpPackages.composer
   julia
   calibre
   wl-clipboard
   xclip
   solaar
   logiops
   input-remapper
   gimp
   krita
   libreoffice-fresh
   onlyoffice-desktopeditors
   zoom-us
  ];

  # Soporte para dispositivos inalámbricos Logitech (MX Master 3S)
  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;

  services.flatpak.enable = true;
  virtualisation.docker.enable = true;

services.pcscd.enable = true;
programs.gnupg.agent = {
 enable = true;
 enableSSHSupport = true;
};

# ================================================================
# ARQUITECTURA DE ALMACENAMIENTO (TIERED STORAGE)
# ================================================================

fileSystems."/mnt/fast-games" = {
 device = "/dev/disk/by-label/FAST_GAMES";
 fsType = "ntfs-3g";
 options = ["rw" "uid=1000" "gid=100" "umask=000" "exec" "nofail" ];
};

fileSystems."/mnt/hdd1" = {
 device = "/dev/disk/by-label/disco_a";
 fsType = "ntfs-3g";
 options = ["rw" "uid=1000" "gid=100" "nofail" ];
};

fileSystems."/mnt/arcade-vault" = {
 device = "/mnt/hdd1";
 fsType = "fuse.mergerfs";
 options = [
 "defaults" 
 "allow_other"
 "use_ino"
 "category.create=mfs"
 "minfreespace=10G"
 "nofail"
];
};

  # ================================================================
  # HARDWARE: GESTIÓN DE PANTALLAS (MODO FOCUS / BASE)
  # ================================================================
  # Apagamos el puerto HDMI a nivel DRM para que no exista para el sistema.
  boot.kernelParams = [ 
    "video=HDMI-A-1:d" 
  ];

  # ================================================================
  # ESPECIALIZACIONES: SELECTOR DE CONTEXTO
  # ================================================================
  specialisation = {
    
    # --- MODO 2: DESKTOP GAMING ---
    desktop-gaming.configuration = {
      system.nixos.tags = [ "Desktop-Gaming" ];
      
      programs.steam.enable = true;
      programs.gamemode.enable = true;
      
      environment.systemPackages = with pkgs; [
        discord
        lutris
        mangohud
        obs-studio
        heroic
        
        # Herramientas para gestionar retro-gaming en escritorio
        steam-rom-manager
      ];
    };

   # --- MODO 3: ARCADE TV ---
    arcade-tv.configuration = {
      system.nixos.tags = [ "Arcade-TV" ];
      
      boot.kernelParams = [ 
        "video=DP-1:d" 
        "video=DP-2:d" 
        "video=DP-3:d" 
        "video=HDMI-A-1:e" 
      ];

      programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
      };
      programs.gamemode.enable = true;
      
      # ------------------------------------------------------------
      # PUNTO 1 & 3: AUTO-LOGIN Y ARRANQUE DE STEAM BIG PICTURE
      # ------------------------------------------------------------
      # Habilitamos el inicio de sesión automático sin contraseña
      services.displayManager.autoLogin.enable = true;
      services.displayManager.autoLogin.user = "luna";
      
      # En lugar de abrir KDE Plasma, forzamos la sesión de Gamescope + Steam
      services.displayManager.defaultSession = "steam";

    }; 
  };
  # ================================================================
  # CONFIGURACIÓN DE VIDEO (AMD GPU)
  # ================================================================
  # Forzar la carga del driver AMD
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Habilitar aceleración gráfica (OpenGL y Vulkan)
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # CRÍTICO para Steam, Wine y juegos retro
  };

  # ================================================================
  # ENTORNO DE ESCRITORIO (Añadiendo KDE Plasma 6 Wayland)
  # ================================================================
  # Puedes mantener Cinnamon habilitado si lo tenías, y agregar Plasma.
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true; # Recomendado para Plasma
  services.displayManager.sddm.wayland.enable = true;

  # ================================================================
  # SINCRONIZACIÓN DE DATOS (Syncthing)
  # ================================================================
  services.syncthing = {
    enable = true;
    user = "luna";
    
    # Carpeta base por defecto (aunque luego puedes mapear carpetas donde quieras)
    dataDir = "/home/luna"; 
    
    # Dónde guarda Syncthing su base de datos y llaves de cifrado
    configDir = "/home/luna/.config/syncthing";
    
    # Esto es magia de NixOS: abre automáticamente los puertos del firewall 
    # (22000 TCP/UDP y 21027 UDP) para que encuentre tus otros dispositivos en la red.
    openDefaultPorts = true; 
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}
