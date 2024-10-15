# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./disk-config.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  # boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  boot.initrd.secrets = {
    "/luks.key" = null;
  };

  boot.initrd.luks.devices.backup = {
    device = "/dev/disk/by-uuid/d8669df4-a24b-453e-9aa1-d58cb2b564a2";
    keyFile = "/luks.key";
  };

  # This is generally a bad idea. :-)
  boot.kernel.sysctl = {
    "vm.swappiness" = 200; 
    "vm.vfs_cache_pressure" = 1;
  };

  networking.hostName = "alpha"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  fonts.packages = with pkgs; [
    noto-fonts
    (nerdfonts.override { fonts = [ "Hack" ]; })
  ];

  # Enable the X11 windowing system.

  services.displayManager = {
    defaultSession = "none+i3";
    autoLogin = {
      enable = true;
      user = "jordan";
    };
  };
  services.xserver = {
    enable = true;
    xautolock = {
      enable = true;
      time = 10;
      locker = "${pkgs.i3lock}/bin/i3lock -i /home/jordan/Pictures/dark-cat.png -u";

    };
    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
        lightdm.enable = true;
        sessionCommands = ''
          xmodmap -e 'pointer = 3 2 1'
          i3lock -i /home/jordan/Pictures/dark-cat.png -u
        '';
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3lock
     ];
    };
    videoDrivers = ["nvidia"];

  };

  services.picom = {
    enable = true;
    fade = true;
    vSync = true;
    backend = "glx";
    settings = {
      corner-radius = 5;
    };
  };

  hardware.graphics.enable = true;


  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;




  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  #hardware.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.jordan = {
     initialPassword = "jordan";
     description = "Jordan A. Steinke";
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       age
       cloudflare-warp
       dropbox
       dropbox-cli
       firefox-bin
       keepassxc
       libreoffice
       llama-cpp
       maim
       mtr
       nixd
       ollama
       pavucontrol
       pinentry-curses
       python312Packages.huggingface-hub
       quickemu
       ripgrep
       sops
       tree
       xclip
       xorg.xmodmap
     ];
   };
   users.defaultUserShell = pkgs.zsh;
   programs.zsh.enable = true;
  environment.variables.EDITOR = "nvim";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;

  services.cloudflare-warp.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 17500 ];
  networking.firewall.allowedUDPPorts = [ 17500 ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  programs.firejail = {
  enable = true;
  wrappedBinaries = {
    chromium = {
      executable = "${pkgs.chromium}/bin/chromium";
      profile = "${pkgs.firejail}/etc/firejail/chromium.profile";
    };
    spotify = {
      executable = "${pkgs.spotify}/bin/spotify";
      profile = "${pkgs.firejail}/etc/firejail/spotify.profile";
    };
    tor-browser = {
      executable = "${pkgs.tor-browser}/bin/tor-browser";
      profile = "${pkgs.firejail}/etc/firejail/tor-browser.profile";
    };
  };
};

  catppuccin = {
    enable = true;
    flavor = "latte";
    accent = "lavender";
  };

  location = {
    provider = "manual";
    latitude = 41.26;
    longitude = -96.0;
  };
  services.redshift.enable = true;

  #for gtk
  programs.dconf.enable = true;

  sops.secrets.mdm-xml = {
    format = "binary";
    sopsFile = ../../secrets/common/mdm.xml;
    path = "/var/lib/cloudflare-warp/mdm.xml";
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  services.borgbackup.jobs.home-jordan = {
    paths = "/home/jordan";
    encryption.mode = "none";
    repo = "/mnt/backup/alpha-home-jordan";
    compression = "none";
    startAt = "hourly";
    user = "jordan";
    exclude = [
      "/home/jordan/.cache"
      "/home/jordan/.ollama"
      "/home/jordan/quickemu"
    ];
    prune.keep = {
      within = "1d"; # Keep all archives from the last day
      daily = 7;
      weekly = 4;
      monthly = -1;  # Keep at least one archive for each month
    };
  };
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "03:45" ]; # Optional; allows customizing optimisation schedule

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };


}

