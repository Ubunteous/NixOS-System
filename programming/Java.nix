{ config, pkgs, user, ... }:

{
  users.users.${user} = {
    packages = with pkgs; [
      jdk # use java/javac to run/compile
      maven # build automation tool
    ];
  };
}
