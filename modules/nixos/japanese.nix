{ pkgs, ... }:

{
  # Japanese fonts and input method
  fonts.packages = with pkgs; [
    ipafont
  ];
  
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
    ];
  };
}