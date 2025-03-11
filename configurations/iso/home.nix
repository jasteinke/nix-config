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
    cursors.enable = true;
    enable = true;

    accent = "lavender";
    flavor = "latte";

    gtk.enable = true;
  };

  gtk.enable = true;

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    size = 24;
  };

  home.file.".background-image/redwood-latte-delta-e-2000.png".source = builtins.fetchurl {
    name = "redwood-latte-delta-e-2000";
    url = "https://drive.google.com/uc?export=download&id=12m1RKKrNBIijdnTPpT7th_k4rG08Tjpf";
    sha256 = "b1c22fea90b5c5d0ca11ee3dd56662a18acf6fe4d05804a351f2df85723e59ae";
  };
}
