{ config, inputs, pkgs, ... }:

{
  imports = [
    ./disk-config.nix
    ./hardware-configuration.nix
    ../../modules/nixos/common.nix
    ../../modules/nixos/gui.nix
    ../../modules/nixos/japanese.nix
    ../../modules/nixos/dropbox.nix
    ../../modules/nixos/radicale.nix
    ../../modules/nixos/searx.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;

  boot.initrd.luks.devices.borgbackup = {
    device = "/dev/disk/by-uuid/d9a4ba4f-ff1f-4ab7-b59f-b59ebc7ed9a2";
    keyFile = "/luks.key";
  };

  boot.initrd.secrets = { "/luks.key" = null; };

  boot.kernel.sysctl = {
    "vm.dirty_background_ratio" = 60;
    "vm.dirty_ratio" = 80;
    "vm.swappiness" = 200;
    "vm.vfs_cache_pressure" = 10;
  };

  virtualisation.spiceUSBRedirection.enable = true;

  #boot.kernelPackages = pkgs.linuxPackages_zen;

  networking.hostName = "desktop-jordan";


  services.picom.backend = "glx";

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
      locker = "${pkgs.xlockmore}/bin/xlock";
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
     ];
    };
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  users = {
#    allowNoPasswordLogin = true;
    groups.ssl.members = [ "radicale" ];
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
  
  security.pki.certificates = [
    (builtins.readFile ../../certs/desktop-jordan_ssl)
  ];

#  security.pam.u2f.settings = {
#    authfile = "/run/secrets/u2f_keys";
#    origin = "nixos";
#    pinverification=1;
#  };
#
#  security.pam.services = {
#    i3lock.u2fAuth = true;
#    login.u2fAuth = true;
#    sudo.u2fAuth = true;
#  };

  services.pcscd.enable = true;

  programs.adb.enable = true;

  environment.systemPackages = with pkgs; [
    age
    amazon-q-cli
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
    gemini-cli
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
  networking.firewall.allowedTCPPorts = [ 8384 22000 5000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];
  services.snowflake-proxy.enable = true;
  services.tailscale.enable = true;
  #services.tailscale.extraSetFlags = [ "--exit-node=us-den-wg-101.mullvad.ts.net"];
  #services.tailscale.useRoutingFeatures ="client";

  services.openssh.enable = true;

  # Configure carefully.
  nix.settings.download-buffer-size = 524288000;

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
      kiwix-desktop = {
        executable = "${pkgs.kiwix}/bin/kiwix-desktop";
        profile = "${pkgs.firejail}/etc/firejail/kiwix-desktop.profile";
      };
      tor-browser = {
        executable = "${pkgs.tor-browser}/bin/tor-browser";
        profile = "${pkgs.firejail}/etc/firejail/tor-browser.profile";
      };
    };
  };
  services.borgbackup.jobs = {
    home-jordan = {
      paths = "/home/jordan";
      encryption.mode = "none";
      exclude = [
        "/home/jordan/.cache"
        "/home/jordan/.config/google-chrome-beta"
        "/home/jordan/guests"
        "/home/jordan/.local/share/kiwix-desktop"
      ];
      repo = "/borgbackup";
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
   home-jordan-zettelkasten = {
      paths = "/home/jordan/zettelkasten";
      encryption = {
        mode = "repokey-blake2";
        passCommand = "cat /run/secrets/borgbackup-passphrase";
      };
      repo = "ssh://ck3mo94g@ck3mo94g.repo.borgbase.com/./repo";
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
    "binary-cache" = {
      format = "binary";
      owner = "jordan";
      sopsFile = ../../secrets/desktop-jordan/binary-cache;
    };
#    "cloudflare-warp" = {
#      format = "binary";
#      path = "/var/lib/cloudflare-warp/mdm.xml";
#      sopsFile = ../../secrets/common/cloudflare-warp;
#    };
    "desktop-jordan_ssl" = {
      format = "binary";
      group = "ssl";
      mode = "640";
      sopsFile = ../../secrets/desktop-jordan/ssl;
    };
    "radicale-passwd" = {
      format = "binary";
      sopsFile = ../../secrets/desktop-jordan/radicale-passwd;
      owner = "radicale";
    };
    "searx" = {
      format = "binary";
      sopsFile = ../../secrets/desktop-jordan/searx;
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
    nix-serve = {
      enable = true;
      bindAddress = "0.0.0.0";
      port = 5000;
      secretKeyFile = "/run/secrets/binary-cache";
    };
    syncthing = {
        enable = true;
        user = "jordan";
        dataDir = "/home/jordan";
        configDir = "/home/jordan/.config/syncthing";
    };
  };
}
