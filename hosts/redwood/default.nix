# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, inputs, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./disk-config.nix
      ./hardware-configuration.nix
      ../../modules/nixos/searx.nix
    ];


  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  # boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  boot.initrd.luks.devices.backup = {
    device = "/dev/disk/by-uuid/eb774644-9565-4ce1-8bad-c8f877f405c7";
    keyFile = "/luks.key";
  };

  boot.initrd.secrets = { "/luks.key" = null; };

  # I disavow these sysctl tweaks. I have *so* much zram and my hard drives are *so* slow. This is probably a bad idea for you. >_>
  boot.kernel.sysctl = {
    "vm.dirty_background_ratio" = 60;
    "vm.dirty_ratio" = 80;
    "vm.swappiness" = 200;
    "vm.vfs_cache_pressure" = 10;
  };

  boot.extraModprobeConfig = ''
    options kvm_intel nested=1
    options kvm_intel emulate_invalid_guest_state=0
    options kvm ignore_msrs=1
  '';
  virtualisation.libvirtd.enable = true;

  #boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_6_6.override { argsOverride = { version = "6.6.67"; }; });

#  boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_6_6.override {
#    argsOverride = rec {
#      src = pkgs.fetchurl {
#            url = "mirror://kernel/linux/kernel/v6.x/linux-${version}.tar.xz";
#            sha256 = "9d757937c4661c2f512c62641b74ef74eff9bb13dc5dbcbaaa108c21152f1e52";
#      };
#      version = "6.6.66";
#      modDirVersion = "6.6.66";
#      };
#  });

  networking.hostName = "redwood"; # Define your hostname.
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
    (nerdfonts.override { fonts = [ "Hack" ]; })
  #  nerd-fonts.hack
  ];

  services.unclutter-xfixes.enable = true;
  services.picom = {
    backend = "glx";
    enable = true;
    vSync = true;
  };
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
  hardware.nvidia.modesetting.enable = true;
  hardware.graphics.enable = true;



  services.xserver = {
    videoDrivers = [ "nvidia" ];
    xautolock = {
      enable = true;
      time = 10;
      locker = "${pkgs.i3lock}/bin/i3lock -c 000000";
    };
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      defaultSession = "none+i3";
      sessionCommands = "xmodmap -e 'pointer = 3 2 1'";
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3lock
     ];
    };
  };


  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jordan = {
    description = "Jordan Steinke";
    isNormalUser = true;
    extraGroups = [ "adbusers" "libvirtd" "wheel" ]; # Enable ‘sudo’ for the user.
  };
  security.sudo.extraConfig = ''
    Defaults        timestamp_timeout=60
  '';

  programs.adb.enable = true;


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    age
    anki-bin
    clang
    clang-tools
    fastfetch
    keepassxc
    maim
    mplayer
    mtr
    neovim
    inputs.nixpkgs-unstable.legacyPackages.x86_64-linux.nixd
    nix-index
    pavucontrol
    quickemu
    ripgrep
    sops
    termdown
    timewarrior
    tree
    wget
    xclip
    xorg.xmodmap
  ];

  programs.steam.enable = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
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
  networking.firewall.enable = true;
  services.cloudflare-warp.enable = true;

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
  system.stateVersion = "24.11"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.variables.EDITOR = "nvim";
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  catppuccin = {
    enable = true;
    accent = "lavender";
    flavor = "latte";
  };

  #I miss you Narnia. :-)
  location= {
    latitude = 41.25405514824386;
    longitude = -96.004614706489;
    provider = "manual";
  };
  services.redshift.enable = true;

  programs.firejail = {
    enable = true;
    wrappedBinaries = {
      chromium = {
        executable = "${pkgs.chromium}/bin/chromium";
        profile = "${pkgs.firejail}/etc/firejail/chromium.profile";
        extraArgs = [
          # Required for U2F USB stick
          "--ignore=private-dev"
          # Enable system notifications
          "--dbus-user.talk=org.freedesktop.Notifications"
        ];
      };
      discord = {
        executable = "${pkgs.discord}/bin/discord";
        profile = "${pkgs.firejail}/etc/firejail/discord.profile";
      };
      tor-browser = {
        executable = "${pkgs.tor-browser}/bin/tor-browser";
        profile = "${pkgs.firejail}/etc/firejail/tor-browser.profile";
      };
    };
  };
  services.syncthing = {
    enable = true;
    user = "jordan";
    openDefaultPorts = true;
    configDir = "/home/jordan/Documents/.config/syncthing";
  };

  services.borgbackup.jobs.redwood-home-jordan = {
    paths = "/home/jordan";
    encryption.mode = "none";
    exclude = [
      "/home/jordan/.cache"
      "/home/jordan/quickemu"
    ];
    repo = "/mnt/backup/redwood-home-jordan";
    compression = "none";
    startAt = "hourly";
    prune.keep = {
      within = "1d"; # Keep all archives from the last day
      daily = 7;
      weekly = 4;
      monthly = -1;  # Keep at least one archive for each month
    };
    user = "jordan";
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  sops.secrets = {
    "cloudflare-warp" = {
      format = "binary";
      path = "/var/lib/cloudflare-warp/mdm.xml";
      sopsFile = ../../secrets/common/cloudflare-warp;
    };
    "searx" = {
      format = "binary";
      sopsFile = ../../secrets/redwood/searx;
    };
  };

  # Needed for easyeffects.
  programs.dconf.enable = true;
}

