{ ... }:
{
  imports = [
    ./easyeffects.nix
    ./firefox.nix
    ./i3.nix
    ./kitty.nix
  ];

  home.file.".background-image/.png".source = builtins.fetchurl {
    name = "solarized_burst";
    url = "https://drive.google.com/uc?export=download&id=17GMrEuxwnidrnyCiM8zEY6SYNFA8beZC";
    sha256 = "eebcfae7828f3420ba317f01e7811b816a6ac2a0390c1725252f7db7be776e45";
  };
}