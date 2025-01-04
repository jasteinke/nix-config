{ ... }:

{
  programs.less = {
    enable = true;
    keys = ''
      e forw-line
      i back-line

      k repeat-search
      K reverse-search
    '';
  };
}
