{ config, lib, ... }:

{
  services.searx = {
    enable = true;
    redisCreateLocally = true;
    settings = {
      enabled_plugins = [
        "Basic Calculator"
        "Hash plugin"
        "Hostnames plugin"
        "Open Access DOI rewrite"
        "Tor check plugin"
        "Tracker URL remover"
        "Unit converter plugin"
      ];
      engines = lib.mapAttrsToList (name: value: { inherit name; } // value) {
        "bing".disabled = false;
        "brave".disabled = false;
        "google".disabled = false;
        "mojeek".disabled = false;
        "qwant".disabled = false;
        "wiby".disabled = false;
      };
      server = {
        bind_address = "127.0.0.1";
        port = 8888;
        public_instance = false;
        secret_key = config.sops.secrets.searx.path;
      };
      ui = {
        default_locale = "en";
        hotkeys = "vim";
        infinite_scroll = true;
      };
    };
  };
}
