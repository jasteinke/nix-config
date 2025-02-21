{ ... }:
{
  home.stateVersion = "24.11";

  imports = [
    ../../modules/home-manager/btop.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/less.nix
    ../../modules/home-manager/nvim/nvim.nix
    ../../modules/home-manager/zsh/zsh.nix
  ];
}
