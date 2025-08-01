{
  config,
  lib,
  pkgs,
  ...
}:

{

  #nixpkgs.config.allowUnfree = true;

  home.username = "mm-2103";
  home.homeDirectory = "/home/mm-2103";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    lazygit
    lazydocker
    ansible-language-server
    antares
    eza
    protonvpn-gui
    sesh
    television
    umu-launcher
    evil-helix
    dysk
    thunderbird
    intelephense
    gimp3
    protonup-qt
    pandoc
    atuin
    texliveSmall
    sqlite
    dust
    tealdeer
    zoxide
    metasploit
    jq
    yq
    rustup
    cliphist
    go
    php
    bun
    htop
    pamixer
    zellij
    btop
    cmake
    prettierd
    ruby
    git-crypt
    zig
    ly
    tmux
    fzf
    networkmanagerapplet
    nwg-look
    mesa-demos
    unigine-heaven
    mangohud
    protonup
    heroic
    git-extras
    delta
    xivlauncher
    keepassxc
    adw-gtk3  # Dark GTK theme
    libsForQt5.qt5ct  # QT theme manager
    gnome-themes-extra  # Extra themes
    opencode
    chromium
    sgdboop
    fastfetch
    mpv
    bat
    rubyPackages.solargraph
    typescript-language-server
    omnisharp-roslyn
    libreoffice-qt6-fresh
    gh
    ripgrep
    git-lfs
    discord
    pavucontrol
    hyprlock
    hypridle
    hyprpaper
    hyprpicker
  ];

  home.sessionVariables = {
    GTK_THEME = "adw-gtk3-dark";  # Dark GTK
    QT_STYLE_OVERRIDE = "breeze";  # Dark QT
    XDG_CURRENT_DESKTOP = "gnome";  # For better app compatibility
  };

  # GTK config for this user
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };

  qt = {
    enable = true;
    style.name = "breeze";
  };

  xdg.mimeApps = {
  enable = true;  # Enables MIME management (creates mimeapps.list)
  
  # Default apps for specific MIME types
  defaultApplications = {
    # PDFs: Open with Okular (KDE's viewer; install via home.packages if needed)
    "application/pdf" = "org.kde.okular.desktop";
    
    # Images: Open with Gwenview (KDE default; or swap to "imv.desktop" for imv)
    "image/jpeg" = "org.kde.gwenview.desktop";
    "image/png" = "org.kde.gwenview.desktop";
    
    # Videos: Open with MPV (lightweight; install via home.packages)
    "video/mp4" = "mpv.desktop";
    "video/x-matroska" = "mpv.desktop";
    
    # Web: Open links with Firefox
    "x-scheme-handler/http" = "app.zen_browser.zen.desktop";
    "x-scheme-handler/https" = "app.zen_browser.zen.desktop";
  };
  
  # Optional: Associations (similar to defaults, but for non-default handlers)
  associations.added = {
    "application/pdf" = [ "org.kde.okular.desktop" ];  # Example: Add extra handlers
  };
};

  home.file = {
    # ~/.config/ destinations
    # ".config/alacritty".source = ../dotfiles/alacritty;
    #    ".config/atuin".source = ../dotfiles/atuin;
    #".config/awesome".source = ../dotfiles/awesome;
    #".config/bspwm".source = ../dotfiles/bspwm;
    #".config/dunst".source = ../dotfiles/dunst;
    #".config/emacs".source = ../dotfiles/emacs;
    #".config/eza".source = ../dotfiles/eza;
    #".config/fastfetch".source = ../dotfiles/fastfetch;
    #".config/fish".source = ../dotfiles/fish;
    #".config/foot".source = ../dotfiles/foot;
    #".config/fuzzel".source = ../dotfiles/fuzzel;
    #".config/ghostty".source = ../dotfiles/ghostty;
    #".config/helix".source = ../dotfiles/helix;
    #".config/hypr".source = ../dotfiles/hypr;
    #".config/i3".source = ../dotfiles/i3;
    #".config/kitty".source = ../dotfiles/kitty;
    #".config/lazygit".source = ../dotfiles/lazygit;
    #".config/mako".source = ../dotfiles/mako;
    #".config/niri".source = ../dotfiles/niri;
    #".config/nix".source = ../dotfiles/nix;
    #".config/nushell".source = ../dotfiles/nushell;
    #".config/nvim".source = ../dotfiles/nvim;
    #".config/picom".source = ../dotfiles/picom;
    #".config/quickshell".source = ../dotfiles/quickshell;
    #".config/river".source = ../dotfiles/river;
    #".config/rofi".source = ../dotfiles/rofi;
    #".config/sesh".source = ../dotfiles/sesh;
    #".config/starship".source = ../dotfiles/starship;
    #".config/swaylock".source = ../dotfiles/swaylock;
    #".config/tmux".source = ../dotfiles/tmux;
    #".config/uwsm".source = ../dotfiles/uwsm;
    #".config/waybar".source = ../dotfiles/waybar;
    #".config/wayfire".source = ../dotfiles/wayfire;
    #".config/wezterm".source = ../dotfiles/wezterm;
    #".config/wireplumber".source = ../dotfiles/wireplumber;
    #".config/xmonad".source = ../dotfiles/xmonad;
    #".config/zsh".source = ../dotfiles/zsh;

    # ~/ destinations (traditional locations)
    #".tmux.conf".source = ../dotfiles/tmate/tmate.conf;  # If you want tmate config as tmux

    # Scripts and other files
    # ".local/bin/dwm-autostart".source = ../dotfiles/dwm/autostart.sh;
    # ".local/bin/gnome-startup".source = ../dotfiles/gnome/startup.sh;
    # ".local/bin/plasma-autostart".source = ../dotfiles/plasma/autostart.sh;
    # ".local/bin/i3-autostart".source = ../dotfiles/i3/autostart.sh;

    # Distrobox images (if you want them accessible)
    # ".local/share/distrobox-images".source = ../dotfiles/distrobox-images;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs = {
    #home-manager.enable = true;

    git = {
      enable = true;
      userName = "mm-2103";
      userEmail = "mohsen.menem@protonmail.com";
    };

    starship.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    emacs = {
      enable = true;
    };

    fuzzel.enable = true;
    waybar.enable = true;
  };

  services = {
    cliphist = {
      enable = true;
      allowImages = true;
    };
    mako.enable = true;
    polkit-gnome.enable = true;
  };
}
