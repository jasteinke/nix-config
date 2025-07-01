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
    ../../modules/home-manager/newsboat.nix
    ../../modules/home-manager/nvim/nvim.nix
    ../../modules/home-manager/thunderbird.nix
    ../../modules/home-manager/zsh/zsh.nix
  ];
  home.file.".background-image/.png".source = builtins.fetchurl {
    name = "solarized_burst";
    url = "https://drive.google.com/uc?export=download&id=17GMrEuxwnidrnyCiM8zEY6SYNFA8beZC";
    sha256 = "eebcfae7828f3420ba317f01e7811b816a6ac2a0390c1725252f7db7be776e45";
  };
}
