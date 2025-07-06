{ pkgs, ... }:

{
  # Desktop-specific fonts
  fonts.packages = with pkgs; [
    inter-alia
    nerd-fonts.hack
  ];
  
  # Desktop services
  services.unclutter-xfixes.enable = true;
  services.picom = {
    enable = true;
    vSync = true;
  };
  
  hardware.graphics.enable = true;
  
  # Display manager
  services.displayManager = {
    autoLogin = {
      user = "jordan";
      enable = true;
    };
    defaultSession = "none+i3";
  };
  
  # X server configuration
  services.xserver = {
    xautolock = {
      enable = true;
      time = 60;
    };
    enable = true;
    
    desktopManager = {
      xterm.enable = false;
    };
    
    displayManager = {
      sessionCommands = ''
        xset dpms 3600 3600 3600
        xset s 3600 3600
      '';
    };
    
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
      ];
    };
  };
  
  # Audio
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  
  # Security
  security.sudo.extraConfig = ''
    Defaults        timestamp_timeout=60
  '';
  
  # Desktop packages
  environment.systemPackages = with pkgs; [
    mplayer
    pulsemixer
    vlc
    xclip
    xorg.xmodmap
    yubioath-flutter
  ];
  
  # Location and display
  location = {
    latitude = 41.25;
    longitude = -96.0;
    provider = "manual";
  };
  
  services.redshift.enable = true;
  
  # Common desktop programs
  programs.adb.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  # Needed for easyeffects
  programs.dconf.enable = true;
  
  # Stylix theming
  stylix.autoEnable = true;
  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/solarized-light.yaml";
}
