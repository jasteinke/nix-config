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
        "Tracker URL remover"
        "Unit converter plugin"
      ];
      engines = lib.mapAttrsToList (name: value: { inherit name; } // value) {
        "bing".disabled = false;
        "brave".disabled = false;
        "duckduckgo".disabled = true;
        "google".disabled = false;
        "qwant".disabled = true;
      };
      search.safe_search = 2;
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

      outgoing.verify = "/etc/ssl/certs/ca-certificates.crt";
      preferences.lock = [
        "safesearch"
      ];
    };
  };
}
