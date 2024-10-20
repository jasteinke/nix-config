{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initExtra = ''
      bindkey -M vicmd n vi-backward-char
      bindkey -M vicmd e vi-down-line-or-history
      bindkey -M vicmd i vi-up-line-or-history
      bindkey -M vicmd o vi-forward-char

      bindkey -M vicmd s vi-insert

      KEYTIMEOUT=10
    '';
  
    shellAliases = {
      b = "btop";
      c = "cd";
      t = "tree";
      v = "nvim";
      z = "cd /home/jordan/zettelkasten; nvim /home/jordan/zettelkasten";
      nz=''cd /home/jordan/zettelkasten; t=$(date -u "+%Y%m%d%H%M%S"); \
        echo "# $t" > "$t.md"; nvim "$t.md"'';

    };
    history = {
      size = 200000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./p10k-config;
        file = "p10k.zsh";
      }
    ];

  };

}
