{ ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      enable_audio_bell = false;
      text_composition_strategy = "legacy";
    };
  };
}
