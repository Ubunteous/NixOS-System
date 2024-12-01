{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.languages.csharp;
  langcfg = config.languages;
  dotnet-script = (pkgs.callPackage ../pkgs/dotnet/dotnet-script.nix { });
in {
  options.languages.csharp = {
    enable = mkEnableOption "Enables support for the C# programming language";
  };

  config = mkIf (langcfg.enable && cfg.enable) {
    users.users.${user} = {
      packages = with pkgs; [
        # editor
        # vscode
        # jetbrains.rider
        # vscode-fhs # to manually install extensions without nix

        # formatter
        csharpier # needs dotnet 6

        # lsp
        omnisharp-roslyn # more powerful, heavier, needs dnet6
        # csharp-ls
        # roslyn-ls # vscode lsp

        # dotnetCorePackages.sdk_X_Y is preferred over old dotnet-sdk
        # consistent major/minor version are important to build a project
        # dotnet-sdk
        # dotnetCorePackages.dotnet_8.sdk

        # combine multiple sdks
        dotnet-script # needs dotnet 8
        (with dotnetCorePackages; combinePackages [ sdk_6_0 sdk_8_0 ])
        # dotnetCorePackages.sdk_8_0

        # roslyn # compiler
        # dotnet-repl
        # dotnet-aspnetcore # old web runtime
      ];
    };

    environment.sessionVariables = {
      DOTNET_CLI_TELEMETRY_OPTOUT = 1;
      # DOTNET_ROOT = "${pkgs.dotnet-sdk}/more/path";
    };
  };
}
