{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-beta-bin;
    profiles.jordan = {
      isDefault = true;
      search = {
        default = "SearXNG";
        engines."SearXNG".urls = [
          { template = "http://127.0.0.1:8888/search?q={searchTerms}"; }
        ];
        force = true;
      };
      settings = {
        "app.normandy.enabled" = false;
        "app.shield.optoutstudies.enabled" = true;
        "browser.contentblocking.category" = true;
        "browser.formfill.enable" = false;
        "browser.newtabpage.enabled" = false;
        "browser.safebrowsing.malware.enabled" = true;
        "browser.safebrowsing.phishing.enabled" = true;
        "browser.startup.page" = 3;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.urlbar.filter.javascript" = true;
        "browser.urlbar.suggest.history" = false;
        "devtools.application.enabled" = false;
        "dom.allow_scripts_to_close_windows" = false;
        "dom.disable_window_flip" = true;
        "dom.disable_window_move_resize" = true;
        "dom.private-attribution.submission.enabled" = false;
        "dom.push.enabled" = false;
        "extensions.blocklist.enabled" = true;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "extensions.update.autoUpdateDefault" = true;
        "extensions.update.enabled" = true;
        "extensions.update.interval" = 86400;
        "extensions.pocket.enabled" = false;
        "geo.enabled" = false;
        "identity.fxaccounts.enabled" = false;
        "media.autoplay.allow-extension-background-pages" = false;
        "media.autoplay.block-event.enabled" = true;
        "media.autoplay.blocking_policy" = 2;
        "media.autoplay.default" = 5;
        "media.eme.enabled" = false;
        "media.peerconnection.enabled" = false;
        "media.peerconnection.use_document_iceservers" = false;
        "network.auth.force-generic-ntlm-v1" = false;
        "network.cookie.cookieBehavior" = 1;
        "network.dns.disablePrefetch" = true;
        "network.IDN_show_punycode" = true;
        "network.protocol-handler.warn-external-default" = true;
        "permissions.default.desktop-notification" = 2;
        "privacy.donottrackheader.enabled" = true;
        "privacy.resistFingerprinting" = true;
        "privacy.resistFingerprinting.pbmode" = true;
        "privacy.resistFingerprinting.randomization.daily_reset.enabled" = true;
        "privacy.resistFingerprinting.randomization.daily_reset.private.enabled" = true;
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
        "ui.key.menuAccessKeyFocuses" = false;
        "xpinstall.whitelist.required" = true;
      };
      userChrome = ''
        #TabsToolbar {
          visibility: collapse;
        }

        #titlebar {
          display: none;
          }

        #sidebar-header {
          display: none;
        }
      '';
    };
  };
}
