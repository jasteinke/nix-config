{ config, lib, pkgs, ... }:

let 
  mod = "Mod1";

  rosewater = "#dc8a78";
  flamingo = "#dd7878";
  pink = "#ea76cb";
  mauve = "#8839ef";
  red = "#d20f39";
  maroon = "#e64553";
  peach = "#fe640b";
  yellow = "#df8e1d";
  green = "#40a02b";
  teal = "#179299";
  sky = "#04a5e5";
  sapphire = "#209fb5";
  blue = "#1e66f5";
  lavender = "#7287fd";
  text = "#4c4f69";
  subtext1 = "#5c5f77";
  subtext0 = "#6c6f85";
  overlay2 = "#7c7f93";
  overlay1 = "#8c8fa1";
  overlay0 = "#9ca0b0";
  surface2 = "#acb0be";
  surface1 = "#bcc0cc";
  surface0 = "#ccd0da";
  base = "#eff1f5";
  mantle = "#e6e9ef";
  crust = "#dce0e8";
in {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;

      window.border = 6;
      window.titlebar = false;

      gaps.inner = 15;


      keybindings = lib.mkOptionDefault {
        "${mod}+s" = "exec ${pkgs.dmenu}/bin/dmenu_run -nb '#eff1f5' -nf '#4c4f69' -sb '#7287fd' -sf '#eff1f5'";
        "${mod}+Return" = "exec ${pkgs.kitty}/bin/kitty";
        "${mod}+x" = "exec sh -c '${pkgs.maim}/bin/maim -s | xclip -selection clipboard -t image/png'";
        "${mod}+Escape" = "exec sh -c '${pkgs.i3lock}/bin/i3lock -i /home/jordan/Pictures/dark-cat.png -u'";

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

      modes.resize = {
        n = "resize grow left 7 px or 7 ppt";
        "Shift+n" = "resize shrink right 7 px or 7 ppt";

        e = "resize grow down 7 px or 7 ppt";
        "Shift+e" = "resize shrink up 7 px or 7 ppt";

        i = "resize grow up 7 px or 7 ppt";
        "Shift+i" = "resize shrink down 7 px or 7 ppt";

        o = "resize grow right 7 px or 7 ppt";
        "Shift+o" = "resize shrink left7 px or 7 ppt";

        Escape = "mode default";
      };

      bars = [
      ];

      colors = {
        background ="${base}";

        focused = {
          background = "${base}";
          border = "${lavender}";
          childBorder = "${lavender}";
          indicator = "${rosewater}";
          text = "${text}";
        };

        focusedInactive = {
          background = "${base}";
          border = "${overlay0}";
          childBorder = "${overlay0}";
          indicator = "${rosewater}";
          text = "${text}";
        };

        placeholder = {
          background = "${base}";
          border = "${overlay0}";
          childBorder = "${overlay0}";
          indicator = "${overlay0}";
          text = "${text}";
        };
        unfocused = {
          background = "${base}";
          border = "${overlay0}";
          childBorder = "${overlay0}";
          indicator = "${rosewater}";
          text = "${text}";
        };
        urgent = {
          background = "${base}";
          border = "${peach}";
          childBorder = "${overlay0}";
          indicator = "${overlay0}";
          text = "${peach}";
        };
      };
    };
  };
}
