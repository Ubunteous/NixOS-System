{ config, pkgs, user, ... }:

{
  users.users.${user} = {
    packages = with pkgs; [
      # Haskell
      ghc
      ## cabal-install # packet manager + build
      ## stack # ghc + package manager + build/test/benchmark
    ];
  };
}
