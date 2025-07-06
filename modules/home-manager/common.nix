{ ... }:
{
  home.stateVersion = "24.11";

  imports = [
    ./btop.nix
    ./git.nix
    ./less.nix
    ./newsboat.nix
    ./nvim/nvim.nix
    ./tmux.nix
    ./zsh/zsh.nix
  ];
}