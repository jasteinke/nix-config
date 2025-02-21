{ ... }:

{
  programs.kitty = {
    enable = true;
      font.name = "Hack Nerd Font";
    settings = {
      enable_audio_bell = false;
      text_composition_strategy = "legacy";
    };
    themeFile = "PaperColor_light";
  };
}
