{ config, pkgs, user, ... }:

{
  users.users.${user} = {
    packages = with pkgs; [
      # java
      # jdk # use java/javac to run/compile

      # Clojure (untested)
      # clojure
      ## leiningen # build automation and dependency management

      # Rust (untested)
      # rustc
      ## cargo # packet manager
      ## rustup # toolchain installer

      # Lua (untested)
      # lua
    ];
  };
}
