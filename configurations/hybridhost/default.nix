{ config, inputs, pkgs, ... }:

{
  imports = [
    ./disk-config.nix
    ./hardware-configuration.nix
    ../../modules/nixos/dropbox.nix
    ../../modules/nixos/searx.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;

  boot.initrd.luks.devices.backup = {
    device = "/dev/disk/by-uuid/705d299c-1e67-472d-acb9-a970b8371eb8";
    keyFile = "/luks.key";
  };

  boot.initrd.secrets = { "/luks.key" = null; };

  boot.kernel.sysctl = {
    "vm.dirty_background_ratio" = 60;
    "vm.dirty_ratio" = 80;
    "vm.swappiness" = 200;
    "vm.vfs_cache_pressure" = 10;
  };

  #boot.kernelPackages = pkgs.linuxPackages_zen;

  networking.hostName = "hybridhost";

  time.timeZone = "America/Chicago";

  fonts.packages = with pkgs; [
    ipafont
    nerd-fonts.hack
  ];

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
    ];
  };

  services.unclutter-xfixes.enable = true;
  services.picom = {
    backend = "glx";
    enable = true;
    vSync = true;
  };

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
  hardware.nvidia.modesetting.enable = true;
  hardware.graphics.enable = true;

  services.displayManager = {
    autoLogin = {
      user = "jordan";
      enable = true;
    };
    defaultSession = "none+i3";
  };

  services.xserver = {
    videoDrivers = [ "nvidia" ];
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
    users.root.hashedPassword = "*";
    users.jordan = {
      description = "Jordan Steinke";
      extraGroups = [ "adbusers" "wheel" ];
      hashedPassword = "*";
      isNormalUser = true;
    };
  };

  security.sudo.extraConfig = ''
    Defaults        timestamp_timeout=60
  '';

  security.pam.u2f.settings = {
    authfile = "/run/secrets/u2f_keys";
    origin = "nixos";
    pinverification=1;
  };

  security.pam.services = {
    i3lock.u2fAuth = true;
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };

  services.pcscd.enable = true;

  programs.adb.enable = true;

  environment.systemPackages = with pkgs; [
    age
    anki-bin
    calibre
    clang
    clang-tools
    dig
    endgame-singularity
    endless-sky
    fastfetch
    ffmpeg
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
    pulsemixer
    quickemu
    ripgrep
    rustc
    sops
    spotify
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

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;

  networking.firewall.enable = true;

  services.cloudflare-warp.enable = true;

  # Configure carefully.
  system.stateVersion = "24.11";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.variables.EDITOR = "nvim";
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  catppuccin = {
    enable = true;
    accent = "lavender";
    flavor = "latte";
  };

  location= {
    latitude = 41.25;
    longitude = -96.0;
    provider = "manual";
  };

  services.redshift.enable = true;

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
      google-chrome-beta = {
        executable = "${inputs.browser-previews.packages.x86_64-linux.google-chrome-beta}/bin/google-chrome-beta";
        profile = "${pkgs.firejail}/etc/firejail/google-chrome-beta.profile";
        extraArgs = [
          # Required for U2F USB stick
          "--ignore=private-dev"
          # Enable system notifications
          "--dbus-user.talk=org.freedesktop.Notifications"
        ];
      };
      kiwix = {
        executable = "${pkgs.kiwix}/bin/kiwix-desktop";
        profile = "${pkgs.firejail}/etc/firejail/kiwix-desktop.profile";
      };
      tor-browser = {
        executable = "${pkgs.tor-browser}/bin/tor-browser";
        profile = "${pkgs.firejail}/etc/firejail/tor-browser.profile";
      };

      ungoogled-chromium = {
        executable = "${pkgs.ungoogled-chromium}/bin/chromium";
        profile = "${pkgs.firejail}/etc/firejail/chromium.profile";
        extraArgs = [
          # Required for U2F USB stick
          "--ignore=private-dev"
          # Enable system notifications
          "--dbus-user.talk=org.freedesktop.Notifications"
        ];
      };
    };
  };

  environment.etc = {
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

  services.borgbackup.jobs = {
    hybridhost-home-jordan = {
      paths = "/home/jordan";
      encryption.mode = "none";
      exclude = [
        "/home/jordan/.cache"
        "/home/jordan/.config/google-chrome-beta"
        "/home/jordan/guests"
      ];
      repo = "/mnt/backup/hybridhost-home-jordan";
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
    hybridhost-home-zettelkasten = {
      paths = "/home/jordan/zettelkasten";
      encryption = {
        mode = "repokey-blake2";
        passCommand = "cat /run/secrets/borgbackup-passphrase";
      };
      repo = "ssh://o1jfie6a@o1jfie6a.repo.borgbase.com/./repo";
      environment.BORG_RSH = "ssh -i /run/secrets/borgbackup-ssh";
      compression = "auto,lzma";
      startAt = "hourly";
      prune.keep = {
        within = "1d"; # Keep all archives from the last day
        daily = 7;
        weekly = 4;
        monthly = -1;  # Keep at least one archive for each month
      };
      user = "jordan";
    };
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

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
    "cloudflare-warp" = {
      format = "binary";
      path = "/var/lib/cloudflare-warp/mdm.xml";
      sopsFile = ../../secrets/common/cloudflare-warp;
    };
    "searx" = {
      format = "binary";
      sopsFile = ../../secrets/hybridhost/searx;
    };
    "u2f_keys" = {
      format = "binary";
      owner = "jordan";
      sopsFile = ../../secrets/common/u2f_keys;
    };
  };

  security.pki.certificateFiles = [
    ../../certs/c622d5ed-8944-4dcd-915b-6e6f0efbc474.crt
    ../../certs/jas.crt
  ];

  # Needed for easyeffects.
  programs.dconf.enable = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "03:45" ];
}
