{ lib, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    extraConfig = lib.fileContents ./init.vim;
    extraLuaConfig = ''
      ${builtins.readFile ./lua/nvim-cmp.lua}
    '';
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      nvim-cmp

      cmp-vsnip
      vim-vsnip


      vim-airline
      vim-airline-clock
      vim-airline-themes

      plenary-nvim
      telescope-nvim

      (nvim-treesitter.withPlugins (p: [ p.cpp p.nix p.rust]))
      nvim-treesitter-context

      vim-markdown
      render-markdown-nvim
    ];
  };
}
