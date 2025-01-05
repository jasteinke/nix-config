{ ... }:
{
  home.stateVersion = "24.11";

  imports = [
    ../../modules/home-manager/btop.nix
    ../../modules/home-manager/easyeffects.nix
    ../../modules/home-manager/firefox.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/i3.nix
    ../../modules/home-manager/kitty.nix
    ../../modules/home-manager/less.nix
    ../../modules/home-manager/nvim/nvim.nix
    ../../modules/home-manager/zsh/zsh.nix
  ];

  catppuccin = {
    enable = true;
    accent = "lavender";
    flavor = "latte";
  };
}
