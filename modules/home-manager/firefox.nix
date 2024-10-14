{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-bin;
    profiles.jordan = {
      isDefault = true;
    };
  };
}
