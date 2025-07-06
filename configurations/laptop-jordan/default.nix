{ config, inputs, pkgs, ... }:

{
  imports = [
    ./disk-config.nix
    ./hardware-configuration.nix
    ../../modules/nixos/common.nix
    ../../modules/nixos/gui.nix
    ../../modules/nixos/japanese.nix
    #../../modules/nixos/dropbox.nix
    #../../modules/nixos/searx.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;

#  boot.initrd.luks.devices.backup = {
#    device = "/dev/disk/by-uuid/705d299c-1e67-472d-acb9-a970b8371eb8";
#    keyFile = "/luks.key";
#  };
#
#  boot.initrd.secrets = { "/luks.key" = null; };

  boot.kernel.sysctl = {
    "vm.dirty_background_ratio" = 60;
    "vm.dirty_ratio" = 80;
    "vm.swappiness" = 200;
    "vm.vfs_cache_pressure" = 10;
  };

  virtualisation.spiceUSBRedirection.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_zen;

  networking.hostName = "laptop-jordan";


  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
    ];
  };
  console.useXkbConfig = true;
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "colemak_dh_iso";
    xkb.options = "caps:swapescape,lv3:ralt_alt";
  };



  services.unclutter-xfixes.enable = true;
  services.picom = {
    #backend = "glx";
    enable = true;
    vSync = true;
  };

  #hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
  #hardware.nvidia.modesetting.enable = true;
  hardware.graphics.enable = true;

  services.displayManager = {
    autoLogin = {
      user = "jordan";
      enable = true;
    };
    defaultSession = "none+i3";
  };

  services.xserver = {
    #videoDrivers = [ "nvidia" ];
    xautolock = {
      enable = true;
      time = 60;
      locker = "${pkgs.xlockmore}/bin/xlock";
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

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  users = {
#    allowNoPasswordLogin = true;
#    mutableUsers = false;
#    users.root.hashedPassword = "*";
    users.jordan = {
      extraGroups = [ "adbusers" "wheel" ];
#     hashedPassword = "*";
      isNormalUser = true;
    };
  };

  security.sudo.extraConfig = ''
    Defaults        timestamp_timeout=60
  '';

#  security.pam.u2f.settings = {
#    authfile = "/run/secrets/u2f_keys";
#    origin = "nixos";
#    pinverification=1;
#  };
#
  security.pam.services = {
    xlock.fprintAuth = true;
    login.fprintAuth = true;
    sudo.fprintAuth = true;
  };
  services.fprintd.enable = true;

  services.pcscd.enable = true;

  programs.adb.enable = true;

  environment.systemPackages = with pkgs; [
    age
    #amazon-q-cli
    anki-bin
    calibre
    clang
    clang-tools
    claude-code
    dig
    endgame-singularity
    endless-sky
    fastfetch
    ffmpeg
    fortune
    #gemini-cli
    ghc
    ghidra-bin
    gimp
    haskell-language-server
    heroic
    kdePackages.okular
    keepassxc
    libreoffice
    luanti
    maim
    mindustry
    mplayer
    mtr
    neovim
    nixd
    nix-index
    ollama
    pavucontrol
    pulsemixer
    quickemu
    ripgrep
    rustc
    sops
    spotify
    spotify-player
    steam
    tcpdump
    termdown
    texliveMedium
    timewarrior
    tree
    unzip
    viu
    vlc
    wget
    wireshark
    xclip
    xorg.xmodmap
    yubioath-flutter
  ];

  nixpkgs.config.nvidia.acceptLicense = true;

  #services.cloudflare-warp.enable = true;
  networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];
  networking.networkmanager.enable = true;

  services.tailscale.enable = true;
  #services.tailscale.extraSetFlags = [ "--exit-node=us-den-wg-101.mullvad.ts.net"];
  #services.tailscale.useRoutingFeatures ="client";

  # Configure carefully.
#  nix.settings.substituters = [
#    "http://desktop-jordan:5000/"
#  ];
#  nix.settings.trusted-public-keys = [
#    "desktop-jordan:vV9ZOe7LigVpaKv/w0EksTYdsE2WbgxwHuXOWtM2Yfw="
#  ];


  programs.firejail = {
    enable = true;
    wrappedBinaries = {
      discord = {
        executable = "${pkgs.discord}/bin/discord";
        profile = "${pkgs.firejail}/etc/firejail/discord.profile";
        extraArgs = [
          # Required for U2F USB stick
          "--ignore=private-dev"
          # Enable system notifications
          "--dbus-user.talk=org.freedesktop.Notifications"
        ];
      };
#      google-chrome-beta = {
#        executable = "${inputs.browser-previews.packages.x86_64-linux.google-chrome-beta}/bin/google-chrome-beta";
#        profile = "${pkgs.firejail}/etc/firejail/google-chrome-beta.profile";
#        extraArgs = [
#          # Required for U2F USB stick
#          "--ignore=private-dev"
#          # Enable system notifications
#          "--dbus-user.talk=org.freedesktop.Notifications"
#        ];
#      };
      kiwix-desktop = {
        executable = "${pkgs.kiwix}/bin/kiwix-desktop";
        profile = "${pkgs.firejail}/etc/firejail/kiwix-desktop.profile";
      };
      tor-browser = {
        executable = "${pkgs.tor-browser}/bin/tor-browser";
        profile = "${pkgs.firejail}/etc/firejail/tor-browser.profile";
      };
#      ungoogled-chromium = {
#        executable = "${pkgs.ungoogled-chromium}/bin/chromium";
#        profile = "${pkgs.firejail}/etc/firejail/chromium.profile";
#        extraArgs = [
#          # Required for U2F USB stick
#          "--ignore=private-dev"
#          # Enable system notifications
#          "--dbus-user.talk=org.freedesktop.Notifications"
#        ];
#      };
    };
  };

  environment.etc = {
    "firejail/discord.local".text = ''
      noblacklist ''\${HOME}/Downloads
      whitelist ''\${HOME}/Downloads
    '';
    "firejail/google-chrome-beta.local".text = ''
      noblacklist ''\${RUNUSER}/app
      noblacklist ''\${HOME}/Documents
      noblacklist ''\${HOME}/Pictures

      mkdir ''\${RUNUSER}/app/org.keepassxc.KeePassXC
      whitelist ''\${RUNUSER}/app/org.keepassxc.KeePassXC
      whitelist ''\${HOME}/Documents
      whitelist ''\${HOME}/Pictures
    '';
  };

#  services.borgbackup.jobs = {
#    laptop-jordan-home-jordan = {
#      paths = "/home/jordan";
#      encryption.mode = "none";
#      exclude = [
#        "/home/jordan/.cache"
#        "/home/jordan/.config/google-chrome-beta"
#        "/home/jordan/guests"
#      ];
#      repo = "/mnt/backup/laptop-jordan-home-jordan";
#      compression = "none";
#      startAt = "hourly";
#      prune.keep = {
#        within = "1d"; # Keep all archives from the last day
#        daily = 7;
#        weekly = 4;
#        monthly = -1;  # Keep at least one archive for each month
#      };
#      user = "jordan";
#    };
#  };


  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  sops.secrets = {
    "borgbackup-passphrase" = {
      format = "binary";
      owner = "jordan";
      sopsFile = ../../secrets/common/borgbackup-passphrase;
    };
    "borgbackup-ssh" = {
      format = "binary";
      owner = "jordan";
      sopsFile = ../../secrets/common/borgbackup-ssh;
    };
#    "u2f_keys" = {
#      format = "binary";
#      owner = "jordan";
#      sopsFile = ../../secrets/common/u2f_keys;
#    };
  };


  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "03:45" ];

  services = {
    syncthing = {
        enable = true;
        user = "jordan";
        dataDir = "/home/jordan";
        configDir = "/home/jordan/.config/syncthing";
    };
  };
  stylix.autoEnable = true;
  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/solarized-light.yaml";
  stylix.fonts = {
    monospace = {
      package = pkgs.nerd-fonts.hack;
      name = "Hack Nerd Font Mono";
    };
    sansSerif = {
      package = pkgs.nerd-fonts.hack;
      name = "Hack Nerd Font";
    };
    serif = {
      package = pkgs.nerd-fonts.hack;
      name = "Hack Nerd Font";
    };
    sizes = {
      applications = 16;
      terminal = 16;
      desktop = 16;
      popups = 16;
    };
  };


}
