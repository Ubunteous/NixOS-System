{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.home.music.u-he;
  homecfg = config.home;

  pluginsPkgsByName = mapAttrs' (
    pluginName: pluginValue:
    nameValuePair (pluginValue.name) (pkgs.callPackage ../../pkgs/u-he/u-he.nix pluginValue)
  ) (import ../../pkgs/u-he/plugins.nix);

  filesForPlugins = lib.attrsets.concatMapAttrs (pluginName: pluginPkg: {
    ".u-he/${pluginName}" = {
      source = "${pluginPkg}/lib/${pluginName}";
      recursive = true; # one symlink/preset to keep the directory editable for more presets
    };

    ".clap/u-he/${pluginName}.64.clap".source = "${pluginPkg}/lib/${pluginName}/${pluginName}.64.so";
  }) pluginsPkgsByName;
in
{
  options.home.music.u-he = {
    enable = mkEnableOption "Enable support for u-he plugins";
  };

  config = mkIf (homecfg.enable && cfg.enable) {
    home.packages = (attrValues pluginsPkgsByName);
    home.file = filesForPlugins;
  };
}
