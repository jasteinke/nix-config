{ config, inputs, lib, pkgs, ... }:

let
  mod = "Mod4";

  rosewater = "#dc8a78";
  peach = "#fe640b";
  lavender = "#7287fd";
  text = "#4c4f69";
  overlay0 = "#9ca0b0";
  base = "#eff1f5";

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
        "${mod}+s" = "exec ${pkgs.dmenu}/bin/dmenu_run -nb '#eff1f5' -sf '#4c4f69' -sb '#7287fd' -nf '#4c4f69'";
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
          background = "${base}";
          border = "${lavender}";
          childBorder = "${lavender}";
          text = "${text}";
          indicator = "${rosewater}";
        };
        focusedInactive = {
          background = "${base}";
          border = "${overlay0}";
          childBorder = "${overlay0}";
          text = "${text}";
          indicator = "${rosewater}";
        };
        unfocused = {
          background = "${base}";
          border = "${overlay0}";
          childBorder = "${overlay0}";
          text = "${text}";
          indicator = "${rosewater}";
        };
        urgent = {
          background = "${base}";
          border = "${peach}";
          childBorder = "${peach}";
          text = "${peach}";
          indicator = "${overlay0}";
        };
        placeholder = {
          background = "${base}";
          border = "${overlay0}";
          childBorder = "${overlay0}";
          text = "${text}";
          indicator = "${overlay0}";
        };
        background = "${base}";
      };

    };
  };
}
