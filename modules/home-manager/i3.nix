{ config, lib, pkgs, ... }:

let 
  mod = "Mod1";
in {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;

      window.titlebar = false;


      keybindings = lib.mkOptionDefault {
        "${mod}+s" = "exec ${pkgs.dmenu}/bin/dmenu_run";
        "${mod}+Return" = "exec ${pkgs.kitty}/bin/kitty";
        "${mod}+x" = "exec sh -c '${pkgs.maim}/bin/maim -s | xclip -selection clipboard -t image/png'";
        "${mod}+Escape" = "exec sh -c '${pkgs.i3lock}/bin/i3lock -c 000000'";

        # Focus
        "${mod}+n" = "focus left";
        "${mod}+e" = "focus down";
        "${mod}+i" = "focus up";
        "${mod}+o" = "focus right";

        # Move
        "${mod}+Shift+n" = "move left";
        "${mod}+Shift+e" = "move down";
        "${mod}+Shift+i" = "move up";
        "${mod}+Shift+o" = "move right";

      };

      bars = [
      ];
    };
  };
}
