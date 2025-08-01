{
  disko.devices = {
    disk = {
      disk0 = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-WD_BLACK_SN770_1TB_242809801134";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "4096M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                passwordFile = "/tmp/secret.key";
                settings = {
                  allowDiscards = true;
                };
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                    "/home" = {
                      mountpoint = "/home";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                    "/tmp" = {
                      mountpoint = "/tmp";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                    "/tmp/priv" = {
                      mountpoint = "/tmp/priv";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                    "/var" = {
                      mountpoint = "/var";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                    "/var/tmp" = {
                      mountpoint = "/var/tmp";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                    "/var/log" = {
                      mountpoint = "/var/log";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                    "/var/log/audit" = {
                      mountpoint = "/var/log/audit";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
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
