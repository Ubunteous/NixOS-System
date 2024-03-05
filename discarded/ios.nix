{ config, pkgs, ... }:

{
  # mkdir /tmp/ios/
  # ifuse /tmp/ios
  # fusermount -u /tmp/ios 

  services.usbmuxd.enable = true;

  environment.systemPackages = with pkgs; [
    libimobiledevice
    ifuse # optional, to mount using 'ifuse'
  ];
}
