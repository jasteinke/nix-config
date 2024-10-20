{ config, pkgs, ... }:

{
  home.stateVersion = "24.05";

  imports = [
    ./btop.nix
    ./dropbox.nix
    ./firefox.nix
    ./git.nix
    ./gtk.nix
    ./i18n.nix
    ./i3.nix
    ./kitty.nix
    ./less.nix
    ./nvim/nvim.nix
    ./thunderbird.nix
    ./zsh/zsh.nix

  ];

  catppuccin = {
    enable = true;
    flavor = "latte";
    accent = "lavender";
  };
}
