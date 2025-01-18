{ ... }:

{
  programs.newsboat = {
    autoReload = true;
    enable = true;
    extraConfig = ''
      bind-key  e down
      bind-key  i up

    '';
    reloadTime = 1440;
    urls = [
      { url = "https://www.citationneeded.news/rss/"; }
      { url = "https://computer.rip/rss.xml"; }
      { url = "https://act.eff.org/action.atom"; }
      { url = "https://www.eff.org/rss/updates.xml"; }
      { url = "https://www.erininthemorning.com/feed"; }
      { url = "https://www.icann.org/news.rss"; }
      { url = "https://notado.app/feeds/jado/software-development"; }
      { url = "https://www.opensecrets.org/news/feed"; }
      { url = "https://pluralistic.net/feed/"; }
      { url = "https://prisonjournalismproject.org/feed/"; }
      { url = "https://feeds.propublica.org/propublica/main"; }
      { url = "https://publicdomainreview.org/rss.xml"; }
      { url = "https://www.rand.org/pubs/new.xml"; }
      { url = "https://www.technologyreview.com/stream/rss/"; }
      { url = "http://www.unicornriot.ninja/?feed=rss2"; }
    ];
  };
}
