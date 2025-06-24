{ config, pkgs, ... }:

{
  imports = [
    ./disk-config.nix
    ./hardware-configuration.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.device = "nodev";

  networking.hostName = "webserver";
  time.timeZone = "America/Chicago";

  users = {
    users.jordan = {
      description = "Jordan Steinke";
      extraGroups = [ "adbusers"  "wheel" ];
      initialPassword = "changeme";
      isNormalUser = true;
    };
  };

  environment.systemPackages = with pkgs; [
    age
    cloudflared
    fastfetch
    gnupg
    mtr
    neovim
    nixd
    nix-index
    php
    sops
    tmux
    tree
    unzip
    wget
  ];

  nixpkgs.config.allowUnfree = true;

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
  services.openssh = {
    enable = true;
    extraConfig = ''
      StreamLocalBindUnlink yes
    '';
  };

  # Configure carefully.
  system.stateVersion = "24.11";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.variables.EDITOR = "nvim";
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  services.cloudflared = {
    enable = true;
    tunnels = {
      "c0b1a694-062a-4f45-a4f6-0185afc0229a" = {
        credentialsFile = "${config.sops.secrets.cloudflared-webserver.path}";
        ingress = {
          "steinke.foo" = "http://localhost:8080";
        };
        default = "http_status:404";
      };
    };
  };
  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
#  sops.secrets = {
#    "cloudflared" = {
#      format = "binary";
#      owner = "cloudflared";
#      sopsFile = ../../secrets/webserver/cloudflared;
#    };
  };

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
