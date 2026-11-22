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
    # Important: only essential files are installed to prevent bloating home manager with
    # thousands of presets and images links. Install the .u-he folders manually if needed

    # ".u-he/${pluginName}" = {
    #   source = "${pluginPkg}/lib/${pluginName}";
    #   recursive = true; # one symlink/preset to keep the directory editable for more presets
    # };

    # ".u-he/${pluginName}/${pluginName}.64.so" = {
    #   source = "${pluginPkg}/lib/${pluginName}/${pluginName}.64.so";
    # };

    # ".u-he/${pluginName}/dialog" = {
    #   source = "${pluginPkg}/lib/${pluginName}/dialog";
    # };

    # ".u-he/${pluginName}/dialog.64" = {
    #   source = "${pluginPkg}/lib/${pluginName}/dialog.64";
    # };

    ".clap/u-he/${pluginName}.64.clap".source = "${pluginPkg}/lib/${pluginName}/${pluginName}.64.so";
  }) pluginsPkgsByName;
in
{
  options.home.music.u-he = {
    enable = mkEnableOption "Enable support for u-he plugins";
  };

  config = mkIf (homecfg.enable && cfg.enable) {
	# runs on every home manager switch
	# important: installing a new version of the synth will not cause a rebuild
	home.activation = lib.mapAttrs'
      (name: plugin: lib.nameValuePair "copyUhe${name}"
		(lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          if [ ! -d "$HOME/.u-he/${name}" ]; then
            mkdir -p "$HOME/.u-he/${name}"
            cp -rn --no-preserve=mode "${plugin}/lib/${name}/." "$HOME/.u-he/${name}/"
		    chmod 744 $HOME/.u-he/${name}/{dialog,dialog.64}
        fi
		''))
      pluginsPkgsByName;

    # home.packages = (attrValues pluginsPkgsByName); # not needed and causes conflict on file install.sh
    home.file = filesForPlugins;
  };
}
