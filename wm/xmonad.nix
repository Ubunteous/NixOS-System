{ pkgs, user, ... }:
# imported from services.nix

{
  # Enable the XMonad Window Manager.
  # services.xserver.displayManager.defaultSession = "none+xmonad";
  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    extraPackages =
      haskellPackages: [
        haskellPackages.xmonad
        # haskellPackages.xmobar
        # haskellPackages.xmonad-contrib
        # haskellPackages.xmonad-extras

        # haskellPackages.taffybar # marked as broken. get taffybar instead (the one which is not part of haskellPackages)
      ];
  };

  users.users.${user} = {
    packages = [
      pkgs.xmobar
    ];
  };
}
