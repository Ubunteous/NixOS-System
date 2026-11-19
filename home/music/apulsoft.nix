{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.home.music.apulsoft;
  homecfg = config.home;

  # { Opalize: pkgs.opalize, ... }
  pluginsPkgsByName = mapAttrs' (
    pluginName: pluginValue:
    nameValuePair (pluginValue.name) (pkgs.callPackage ../../pkgs/apulsoft/apulsoft.nix pluginValue)
  ) (import ../../pkgs/apulsoft/plugins.nix);

  filesForPlugins = lib.attrsets.concatMapAttrs (pluginName: pluginPkg: {
    # manual.pdf
    "apulSoft/${pluginName}/${pluginName} Manual.pdf".source =
      "${pluginPkg}/lib/vst3/${pluginName}/${pluginName} Manual.pdf";

    # presets/
    "apulSoft/${pluginName}/Presets" = {
      source = "${pluginPkg}/lib/vst3/${pluginName}/Presets";
      recursive = true; # one symlink/preset to keep the directory editable for more presets
    };

    # LfoCurves/ (apqualizr only)
    "apulSoft/${pluginName}/LfoCurves" =
      mkIf (pathExists "${pluginPkg}/lib/vst3/${pluginName}/LfoCurves")
        {
          source = "${pluginPkg}/lib/vst3/${pluginName}/LfoCurves";
          recursive = true;
        };

    # ColorSchemes/ (most but not opalize notably)
    "apulSoft/${pluginName}/ColorSchemes" =
      mkIf (pathExists "${pluginPkg}/lib/vst3/${pluginName}/ColorSchemes")
        {
          source = "${pluginPkg}/lib/vst3/${pluginName}/ColorSchemes";
          recursive = true;
        };

    # Extra: triggers for apTrigga
  }) pluginsPkgsByName;
in
  {
	options.home.music.apulsoft = {
      enable = mkEnableOption "Enable support for apulsoft plugins";
	};

	config = mkIf (homecfg.enable && cfg.enable) {
    home.packages = (attrValues pluginsPkgsByName);
    xdg.configFile = filesForPlugins;
  };
}
