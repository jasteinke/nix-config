{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-bin;
    profiles.jordan = {
      isDefault = true;
      search.default = "DuckDuckGo";
      search.force = true;
      settings = {
        "app.normandy.enabled" = false;
        "app.shield.optoutstudies.enabled" = true;
        "browser.contentblocking.category" = true;
        "browser.formfill.enable" = false;
        "browser.newtabpage.enabled" = false;
        "browser.safebrowsing.malware.enabled" = true;
        "browser.safebrowsing.phishing.enabled" = true;
        "browser.search.update" = true;
        "browser.startup.page" = 3;
        "browser.urlbar.filter.javascript" = true;
        "dom.allow_scripts_to_close_windows" = false;
        "dom.disable_window_flip" = true;
        "dom.disable_window_move_resize" = true;
        "extensions.blocklist.enabled" = true;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "extensions.pocket.enabled" = false;
        "extensions.update.autoUpdateDefault" = true;
        "extensions.update.enabled" = true;
        "extensions.update.interval" = 86400;
        "geo.enabled" = false;
        "identity.fxaccounts.enabled" = false;
        "media.eme.enabled" = false;
        "media.peerconnection.enabled" = false;
        "media.peerconnection.use_document_iceservers" = false;
        "network.cookie.cookieBehavior" = 1;
        "network.dns.disablePrefetch" = true;
        "network.auth.force-generic-ntlm-v1" = false;
        "network.IDN_show_punycode" = true;
        "network.protocol-handler.warn-external-default" = true;
        "privacy.donottrackheader.enabled" = true;
        "privacy.resistFingerprinting" = true;
        "privacy.sanitize.sanitizeOnShutdown" = false;
        "privacy.trackingprotection.cryptomining.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.pbmode.enabled" = true;
        "security.dialog_enable_delay" = 2000;
        "security.fileuri.strict_origin_policy" = true;
        "security.mixed_content.block_active_content" = true;
        "security.OCSP.enabled" = 1;
        "security.OCSP.require" = true;
        "security.tls.version.max" = 4;
        "security.tls.version.min" = 3;
        "signon.rememberSignons" = false;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "xpinstall.whitelist.required" = true;
      };
      userChrome = ''
        #sidebar-header {
          display: none;
        }
        #TabsToolbar {
          visibility: collapse !important;
        }
      '';
    };
  };
}
