{ ... }:

{
  programs.firefox = {
    enable = true;
    profiles.jordan = {
      isDefault = true;
    };
  };
}
