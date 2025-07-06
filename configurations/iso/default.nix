{ pkgs, ... }:

{
  imports = [
    ../../modules/nixos/common.nix
    ../../modules/nixos/gui.nix
  ];

  networking.hostName = "iso";


  services.unclutter-xfixes.enable = true;
  services.picom = {
    backend = "glx";
    enable = true;
    vSync = true;
  };

  services.displayManager = {
    autoLogin = {
      user = "jordan";
      enable = true;
    };
    defaultSession = "none+i3";
  };

  services.xserver = {
    xautolock = {
      enable = true;
      time = 60;
      locker = "${pkgs.i3lock}/bin/i3lock -u -c 000000";
    };
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      sessionCommands = ''
        xmodmap -e 'pointer = 3 2 1'
        xset dpms 3600 3600 3600
        xset s 3600 3600
      '';
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3lock
     ];
    };
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  users = {
    allowNoPasswordLogin = true;
    mutableUsers = false;
    users.root.password = "root";
    users.jordan = {
      description = "Jordan Steinke";
      extraGroups = [ "adbusers" "wheel" ];
      password = "iso";
      isNormalUser = true;
    };
  };
  security.sudo.extraConfig = ''
    Defaults        timestamp_timeout=60
  '';

  programs.adb.enable = true;

  environment.systemPackages = with pkgs; [
    fastfetch
    mplayer
    mtr
    neovim
    nixd
    nix-index
    pulsemixer
    ripgrep
    sops
    termdown
    tree
    unzip
    vlc
    wget
    xclip
    xorg.xmodmap
    yubioath-flutter
  ];

  services.cloudflare-warp.enable = true;

  # Configure carefully.



  console.colors = [
    "eeeeee"
    "af0000"
    "008700"
    "5f8700"
    "0087af"
    "878787"
    "005f87"
    "444444"
    "bcbcbc"
    "d70000"
    "d70087"
    "8700af"
    "d75f00"
    "d75f00"
    "005faf"
    "005f87"
  ];
}
