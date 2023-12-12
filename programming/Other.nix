{ config, pkgs, user, ... }:

{
  users.users.${user} = {
    packages = with pkgs; [
      # Rust (untested)
      # rustc
      ## cargo # packet manager
      ## rustup # toolchain installer

      # Lua (untested)
      # lua
    ];
  };
}
