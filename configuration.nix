{ config, pkgs, inputs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./nvidia.nix
      <home-manager/nixos>
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking settings
  networking = {
    hostName = "MM-2103-Nix";
    networkmanager = {
      enable = true;
    };
    firewall = {
      enable = true;
      allowedTCPPortRanges = [ 
        { from = 1714; to = 1764; }
      ];
      allowedUDPPortRanges = [
        { from = 1714; to = 1764; }
      ];
    };
  };

  # Flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Optimise store
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "11:59" ];

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  
  # Hardware settings
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    pulseaudio.enable = false;
    xpadneo.enable = true;
  };


  security.rtkit.enable = true;

  services = { 
    mullvad-vpn.enable = true;
    flatpak.enable = true; 
    blueman.enable = true;
    power-profiles-daemon.enable = false;
    system76-scheduler.enable = true;


    xserver = {
      enable = true;
      xkb = {
        variant = "";
        layout = "us";
      };
      wacom.enable = true;
      windowManager = {
        awesome = {
          enable = true;
        };
      };
    };


    displayManager = {
      sddm = {
        enable = true;
        autoNumlock = true;
      };
    };

    desktopManager = {
      plasma6.enable = true;
    };


   pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    # auto-cpufreq
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };


  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mm-2103 = {
    isNormalUser = true;
    description = "Mohsen Menem";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.fish;
    packages = with pkgs; [];
  };
  
  home-manager.users.mm-2103 = { pkgs, ... }: {
    home.packages = [ pkgs.atool pkgs.httpie ];

    home.stateVersion = "24.05";
  };

  programs = {
      steam = {
          enable = true;
          gamescopeSession.enable = true;
        };
        java = {
            enable = true;
          };
	fish = {
	    enable = true;
	};
        firefox = {
            enable = true;
        };
        npm = {
            enable = true;
        };
        kdeconnect = {
            enable = true;
        };
        virt-manager = {
            enable = true;
        };
    };



  # Allow unfree packages
  nixpkgs.config = { 
    allowUnfree = true;

    packageOverrides = pkgs: {
      unstable = import <nixpkgs-unstable> {
        config = config.nixpkgs.config;
      };
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    unstable.neovim
    curl
    git
    go
    gopls
    librewolf
    brave
    kitty
    thunderbird
    tmux
    rofi-unwrapped
    picom
    flameshot
    vlc
    bitwarden
    xarchiver
    lxappearance
    arandr
    xclip
    gh
    brightnessctl
    playerctl
    xss-lock
    xsecurelock
    lutris
    heroic
    gamemode
    gamescope
    mangohud
    wineWowPackages.full
    wineWowPackages.waylandFull
    winetricks
    libreoffice
    dust
    pamixer
    starship
    discord
    qbittorrent
    xf86_input_wacom
    ripgrep
    fd
    lazygit
    wget
    zip
    unzip
    lua
    luajitPackages.luarocks
    tldr
    feh
    gcc
    rustup
    ananicy-cpp
    pcsx2
    fishPlugins.fzf
    fzf
    protonup-qt
    kdePackages.plasma-browser-integration
    fastfetch
    python3
    lz4
    sqlite
    qownnotes
    unstable.floorp
    autorandr
  ];

  virtualisation = {
    docker = {
      enable = true;
    };
    libvirtd = {
      enable = true;
    };
  };
 
  system.stateVersion = "24.05";

}
