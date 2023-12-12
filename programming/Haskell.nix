{ config, pkgs, user, ... }:

{
  users.users.${user} = {
    packages = with pkgs; [
      # Haskell
      ghc

      # haskellPackages.kmonad # currently broken in 22.11
      # cabal-install # packet manager + build
      # stack # ghc + package manager + build/test/benchmark
    ];
  };
}
