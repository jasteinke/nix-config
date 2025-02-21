{ ... }:
{
  home.stateVersion = "24.11";

  imports = [
    ../../modules/home-manager/btop.nix
    ../../modules/home-manager/easyeffects.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/i3.nix
    ../../modules/home-manager/kitty.nix
    ../../modules/home-manager/less.nix
    ../../modules/home-manager/nvim/nvim.nix
    ../../modules/home-manager/zsh/zsh.nix
  ];

  home.file.".background-image/eeeeee.png".source = builtins.fetchurl {
    name = "eeeeee";
    url = "https://drive.google.com/uc?export=download&id=1rw7sIhX2Qv29Xat5zlFi-D0ERPbBUAC-";
    sha256 = "1cb6651499ff0660a19be3d601a605acd4623474b31154575d6b7518d4767330";
  };
}
