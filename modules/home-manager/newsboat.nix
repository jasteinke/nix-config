{ ... }:

{
  programs.newsboat = {
    enable = true;

    autoReload = true;
    reloadTime = 1440;

    extraConfig = ''
      bind-key e down
      bind-key i up
    '';

    urls = [
      { url = "https://www.citationneeded.news/rss/"; }
      { url = "https://computer.rip/rss.xml"; }
      { url = "https://www.erininthemorning.com/feed"; }
      { url = "https://www.nsa.gov/DesktopModules/ArticleCS/RSS.ashx?ContentType=1&Site=1282&max=20"; }
      { url = "https://www.opensecrets.org/news/feed"; }
      { url = "https://pluralistic.net/feed/"; }
      { url = "https://prisonjournalismproject.org/feed/"; }
      { url = "https://feeds.propublica.org/propublica/main"; }
      { url = "https://publicdomainreview.org/rss.xml"; }
      { url = "https://www.technologyreview.com/stream/rss/"; }
      { url = "http://www.unicornriot.ninja/?feed=rss2"; }
    ];
  };
}
