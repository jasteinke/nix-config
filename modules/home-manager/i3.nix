{ config, inputs, lib, pkgs, ... }:

let
  mod = "Mod4";
in {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      defaultWorkspace = "workspace number 2";
      modifier = mod;

      window.border = 3;
      window.titlebar = false;


      keybindings = lib.mkOptionDefault {
        "${mod}+c" = "exec google-chrome-beta --kiosk https://en.wikipedia.org/wiki/Special:Random";
        "${mod}+s" = "exec ${pkgs.dmenu}/bin/dmenu_run -nb '#eeeeee' -sf '#eeeeee' -sb '#005f87' -nf '#444444'";
        "${mod}+x" = "exec sh -c '${pkgs.maim}/bin/maim -s | xclip -selection clipboard -t image/png'";
        "${mod}+Escape" = "exec sh -c '${pkgs.i3lock}/bin/i3lock -u -c 000000'";
        "${mod}+Return" = "exec sh -c '${pkgs.kitty}/bin/kitty'";

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

        "${mod}+r" = "mode resize";
      };

      bars = [
      ];
      modes.resize = {
        n = "resize grow left 10 px or 10 ppt";
        "Shift+n" = "resize shrink right 10 px or 10 ppt";

        e = "resize grow down 10 px or 10 ppt";
        "Shift+e" = "resize shrink up 10 px or 10 ppt";

        i = "resize grow up 10 px or 10 ppt";
        "Shift+i" = "resize shrink down 10 px or 10 ppt";

        o = "resize grow right 10 px or 10 ppt";
        "Shift+o" = "resize shrink left 10 px or 10 ppt";

        Escape = "mode default";
      };
      colors = {
        focused = {
          background   = "#eeeeee";
          border       = "#0087af";
          childBorder  = "#0087af";
          text         = "#444444";
          indicator    = "#5fafd7";
        };
        focusedInactive = {
          background   = "#eeeeee";
          border       = "#d0d0d0";
          childBorder  = "#d0d0d0";
          text         = "#444444";
          indicator    = "#5fafd7";
        };
        unfocused = {
          background   = "#eeeeee";
          border       = "#d0d0d0";
          childBorder  = "#d0d0d0";
          text         = "#444444";
          indicator    = "#5fafd7";
        };
        urgent = {
          background   = "#eeeeee";
          border       = "#d75f00";
          childBorder  = "#d75f00";
          text         = "#d75f00";
          indicator    = "#d0d0d0";
        };
        placeholder = {
          background   = "#eeeeee";
          border       = "#d0d0d0";
          childBorder  = "#d0d0d0";
          text         = "#444444";
          indicator    = "#d0d0d0";
        };
        background = "#eeeeee";
      };
    };
  };
}
