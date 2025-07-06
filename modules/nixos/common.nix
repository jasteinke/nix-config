{ pkgs, ... }:

{
  # Basic system configuration
  time.timeZone = "America/Chicago";
  system.stateVersion = "24.11";
  
  # Nix configuration
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Environment
  environment.variables.EDITOR = "nvim";
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  
  # Nixpkgs configuration
  nixpkgs.config.allowUnfree = true;
  
  # Networking
  networking.firewall.enable = true;
  
  # Jordan user (common across all hosts)
  users.users.jordan = {
    extraGroups = [ "adbusers" "wheel" ];
    isNormalUser = true;
  };
  
  # Common packages (present in all configurations)
  environment.systemPackages = with pkgs; [
    fastfetch
    mtr
    neovim
    nixd
    nix-index
    sops
    tree
    unzip
    wget
  ];
}