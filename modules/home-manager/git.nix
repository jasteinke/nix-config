{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Jordan A. Steinke";
    userEmail = "jasteinke@gmx.com";
  };
}
