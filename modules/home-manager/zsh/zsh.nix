{ config, pkgs, ... }:
{
  programs.zsh = {
    autosuggestion.enable = true;
    enable = true;
    enableCompletion = true;
    history = {
      size = 200000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    initExtra = ''
      bindkey -v

      bindkey -M vicmd n vi-backward-char
      bindkey -M vicmd e vi-down-line-or-history
      bindkey -M vicmd i vi-up-line-or-history
      bindkey -M vicmd o vi-forward-char

      bindkey -M vicmd s vi-insert

      KEYTIMEOUT=10
    '';

    shellAliases = {
      c = "cd";
      cn = "cd ~/Dropbox/nix-config";
      b = "btop";
      n = "newsboat";
      nbi = "nix build .#nixosConfigurations.iso.config.system.build.isoImage";
      nz = ''cd /home/jordan/zettelkasten; ts=$(date -u +%Y%m%d%H%M%S); echo "# $ts.md" >> "$ts.md"; nvim $ts.md'';
      t = "tree";
      v = "nvim";
      z = "cd /home/jordan/zettelkasten; nvim";
    };

    syntaxHighlighting.enable = true;

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
