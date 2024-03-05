# Attempt to display multiple Linux systems in grub

###########################
#   MULTIPLE PARTITIONS   #
###########################

# boot.loader.grub.enable = true;
# boot.loader.grub.version = 2;
boot.loader.grub.device = "nodev";
boot.loader.grub.efiSupport = true;
boot.loader.grub.useOSProber = true;

boot.loader.grub.extraEntries = ''
    menuentry "Mint" --class linuxmint --class os  {
      # insmod part_gpt
      # insmod ext2
      # insmod fat
      # set root=PART_UUID=ce40fb69-c651-4d81-91ac-2413dd74a606
      configfile /EFI/ubuntu/grub.cfg
    }
  '';
