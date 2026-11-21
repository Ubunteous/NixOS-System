{
  lib,
  pkgs,
  ...
}:
let
  plugins = map (plugin: pkgs.callPackage ../pkgs/plogue/plogue.nix plugin) (
    lib.attrValues (import ../pkgs/plogue/plugins.nix)
  );

  # combine packages without running them sequentially
  # (which would overwrite them one after each other besides the last one)
  pluginsEnv = pkgs.symlinkJoin {
    name = "plogue";
    paths = plugins;
  };
in
  {
	# sforzando's VST3/CLAP plugins dlopen "/opt/Plogue/Aria/libAria.so" as a
	# hardcoded string - autoPatchelf can't fix string constants. Symlink the
	# Plogue tree from the nix store so the path resolves without a manual install.

	systemd.tmpfiles.rules = [
      "d /opt 0755 root root - -"
      # Plogue hardcodes access("/usr/bin/zenity") - ignores PATH entirely.
      "L+ /usr/bin/zenity - - - - ${pkgs.zenity}/bin/zenity"

      # do not list/mapconcat plugins as each one would rewrite /opt/Plogue
      "L+ /opt/Plogue - - - - ${pluginsEnv}/Plogue"
	];

	# zenity provides the dialog Plogue products (license)
	environment.systemPackages = [
      pkgs.zenity
	]
  ++ plugins;
}
