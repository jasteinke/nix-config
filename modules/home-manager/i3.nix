{ config, inputs, lib, pkgs, osConfig, ... }:

let
  mod = "Mod1";
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
        "${mod}+s" = "exec ${pkgs.dmenu}/bin/dmenu_run -nb '#FDF6E3' -nf '#586E75' -sb '#93A1A1' -sf '#073642'${if osConfig.networking.hostName == "laptop-jordan" then " -fn 'Hack Nerd Font:size=16'" else ""}";
        "${mod}+x" = "exec sh -c '${pkgs.maim}/bin/maim -s | xclip -selection clipboard -t image/png'";
        "${mod}+Escape" = "exec sh -c '${pkgs.xlockmore}/bin/xlock'";
        "${mod}+Shift+Escape" = "exec sh -c '${pkgs.xlockmore}/bin/xlock & systemctl suspend'";
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
    };
  };
}
