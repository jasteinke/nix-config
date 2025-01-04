{ ... }:

{
  programs.git = {
    enable = true;
    userEmail = "jordan@steinke.foo";
    userName = "Jordan Steinke";
    extraConfig = {
      commit.gpgsign = true;
      init.defaultBranch = "main";
    };
  };
}
