{ config, pkgs, lib, ... }:

{

  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      telescope-nvim
      vim-airline
      vim-airline-clock

      nvim-treesitter-context
      (nvim-treesitter.withPlugins (p: [ p.nix ]))      

      nvim-lspconfig
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      nvim-cmp
      
      cmp-vsnip
      vim-vsnip

      vimtex
      vim-markdown

      render-markdown-nvim

    ];
    enable = true;
    extraConfig = lib.fileContents ./init.vim;
    extraLuaConfig = ''
      ${builtins.readFile ./lua/nvim-cmp.lua}
      ${builtins.readFile ./lua/telescope-nvim.lua}
    '';
  };

}
