{ config, pkgs, user, ... }:

{
  users.users.${user} = {
    packages = with pkgs; [
      java
      jdk # use java/javac to run/compile
    ];
  };
}
