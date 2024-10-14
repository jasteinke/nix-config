{ config, pkgs, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-latte-lavender-compact+default";
      package =
        (pkgs.catppuccin-gtk.overrideAttrs {
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "gtk";
            rev = "v1.0.3";
            fetchSubmodules = true;
            hash = "sha256-q5/VcFsm3vNEw55zq/vcM11eo456SYE5TQA3g2VQjGc=";
          };
    
          postUnpack = "";
        }).override
          {
            accents = [ "lavender" ];
            variant = "latte";
            size = "compact";
          };
    };
  };

}
