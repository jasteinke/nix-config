# Example to create a bios compatible gpt partition
{
  disko.devices = {
    disk = {
      main = {
        device = "/dev/disk/by-id/ata-HUS724020ALA640_P5GMH0WX";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "1M";
              type = "EF02"; # for grub MBR
            };

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
                # disable settings.keyFile if you want to use interactive password entry
                passwordFile = "/tmp/secret.key"; # Interactive
                settings = {
                  allowDiscards = true;
                  #keyFile = "/tmp/secret.key";
                };
                #additionalKeyFiles = [ "/tmp/additionalSecret.key" ];
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
                      mountOptions = [ "compress=zstd" "noatime" "nodev" ];
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                    "/nix/tmp" = {
                      mountpoint = "/nix/tmp";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };

                    "/tmp" = {
                      mountpoint = "/tmp";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                        "nodev"
                        "noexec"
                        "nosuid"
                      ];
                    };

                    "/var" = {
                      mountpoint = "/var";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };

                    "/var/tmp" = {
                      mountpoint = "/var/tmp";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                        "nodev"
                        "noexec"
                        "nosuid"
                      ];
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
    nodev = {
      "/dev/shm" = {
        fsType = "tmpfs";
        mountOptions = [
          "nodev"
          "noexec"
          "nosuid"
          "rw"
        ];
      };
    };
  };
}
