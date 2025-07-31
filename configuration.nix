# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./nvidia.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 20;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Specialisation for LTS kernel (appears as a separate boot entry)
  specialisation = {
    lts.configuration = {
      system.nixos.tags = [ "lts-kernel" ];  # Labels the boot entry (e.g., "NixOS - lts-kernel")
      boot.kernelPackages = lib.mkForce pkgs.linuxPackages_6_12;  # Force-override with LTS (use 6_6 or your preferred)
    };
  };

  networking.hostName = "MM-2103-work"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

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
  
  # Flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Bluetooth
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true; 

  # Xbox Controller
  hardware.xpadneo.enable = true; 

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # Flatpak
  services.flatpak.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.desktopManager.plasma6.enable = true;

  services.displayManager = {
    sddm = {
      package = lib.mkForce pkgs.kdePackages.sddm;
      enable = true;
      wayland.enable = true;  # Recommended for Plasma 6 (if not already)
      theme = "sddm-astronaut-theme";  # Default KDE theme; change if using a custom one (e.g., "elarun")

      # Custom settings for theme overrides (including wallpaper)
      settings = {
        Theme = {
          CursorTheme = "breeze_cursors";  # Matches Plasma
        };
      };
    };
    ly = {
      enable = false;
      # Optional customizations (tweak as needed)
      settings = {
        animation = "none";  # Fun login animation (options: none, matrix, etc.)
        blank_password = false;  # Don't allow empty passwords
        tty = 2;  # Run on TTY2 (default; change if conflicting)
      };
    };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = false;

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

  security.polkit = {
   enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mm-2103 = {
    isNormalUser = true;
    description = "Mohsen Menem";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.fish;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    ansible
    ghostty
    hyprlock
    hypridle
    hyprpaper
    hyprpicker
    xwayland-satellite
    wl-clipboard
    pinentry-curses
    sddm-astronaut
    kdePackages.qtmultimedia
  ];

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.iosevka
      nerd-fonts.zed-mono
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "Iosevka Nerd Font Mono" ];
      };
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  programs.niri.enable = true;
  programs.fish.enable = true;
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
  programs.gamemode.enable = true;

  programs.uwsm = {
    enable = true;
    waylandCompositors = {
      niri = {
        prettyName = "Niri";
        comment = "Niri compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/niri-session";
      };
    };
  };

  programs.foot.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      icu
    ];
  };
  programs.kdeconnect.enable = true;

  # XDG Desktop Portals for sandboxed app integration
  xdg.portal = {
   enable = true;  # Core enablement - required for portals to work
   wlr.enable = true;  # For wlroots-based WMs like Hyprland (safe to enable even if not using it yet)
  
   # Extra portal implementations (pick based on your needs; these cover most cases)
   extraPortals = with pkgs; [
     xdg-desktop-portal-gtk  
     kdePackages.xdg-desktop-portal-kde
     # xdg-desktop-portal-wlr  # Uncomment if using Hyprland/Sway (wlroots); it's lightweight
     # xdg-desktop-portal-hyprland  # Uncomment if fully switching to Hyprland
   ];
  
   # Default config: Prioritize KDE for your Plasma setup, with GTK fallback
   config = {
     common = {
       default = [ "kde" "gtk" ];  # KDE first (matches your DE), then GTK for compatibility
     };
   };
  
   # Optional: Per-interface config (e.g., force GTK for file choosers if KDE acts up)
   # config.common."org.freedesktop.portal.FileChooser" = [ "gtk" ];
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  services.power-profiles-daemon.enable = false;

  services.tlp = {
    enable = true;
    settings = {
      USB_AUTOSUSPEND=0;
      RUNTIME_PM_ENABLE="01:00.0";
    };
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  # Use nftables instead of iptables
  networking.nftables.enable = true;
  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 1714 1764 ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; }  # Opens UDP 1714-1764 inclusive
    ];
  };
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
