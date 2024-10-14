{ config, pkgs, ... }:

{
  programs.thunderbird = {
    enable = true;
    profiles.jordan = {
      isDefault = true;
    };
  };

}
