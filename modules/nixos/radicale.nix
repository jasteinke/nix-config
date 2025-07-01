{ ... }:

{
  environment.etc."desktop-jordan_ssl".text = builtins.readFile ../../certs/desktop-jordan_ssl;
  services.radicale = {
    enable = true;
    settings = {
      server = {
        hosts = [ "0.0.0.0:5232" ];
        ssl = true;
        certificate = [ "/etc/desktop-jordan_ssl" ];
        key = [ "/run/secrets/desktop-jordan_ssl" ];
      };
      auth = {
        type = "htpasswd";
        htpasswd_filename = "/run/secrets/radicale-passwd";
        # hash function used for passwords. May be `plain` if you don't want to hash the passwords
        htpasswd_encryption = "bcrypt";
      };
    };
  };
}
