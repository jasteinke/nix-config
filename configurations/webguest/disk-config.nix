{
  disko.devices = {
    disk = {
      disk0 = {
        type = "disk";
        device = "/dev/vda";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              start = "1M";
              end = "4096M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "/root" = {
                    mountpoint = "/";
                    mountOptions = [ "noatime" ];
                  };
                  "/home" = {
                    mountpoint = "/home";
                    mountOptions = [ "noatime" ];
                  };
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = [ "noatime" ];
                  };
                  "/tmp" = {
                    mountpoint = "/tmp";
                    mountOptions = [ "noatime" ];
                  };
                  "/tmp/priv" = {
                    mountpoint = "/tmp/priv";
                    mountOptions = [ "noatime" ];
                  };
                  "/var" = {
                    mountpoint = "/var";
                    mountOptions = [ "noatime" ];
                  };
                  "/var/tmp" = {
                    mountpoint = "/var/tmp";
                    mountOptions = [ "noatime" ];
                  };
                  "/var/log" = {
                    mountpoint = "/var/log";
                    mountOptions = [ "noatime" ];
                  };
                  "/var/log/audit" = {
                    mountpoint = "/var/log/audit";
                    mountOptions = [ "noatime" ];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
