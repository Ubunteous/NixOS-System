{ config, pkgs, user, ... }:

{
  users.users.${user} = {
    packages = with pkgs; [
      # C/C++
      gcc # use gcc with C and g++ with C++
      # build essentials bundles: gcc/g++,libc6-dev,make,dpkg-dev
    ];
  };
}
