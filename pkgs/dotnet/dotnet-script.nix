{ lib, buildDotnetGlobalTool, dotnetCorePackages, }:

# let
#   dotnetpkgs = (with dotnetCorePackages; combinePackages [ sdk_8_0 sdk_9_0 ]);
#   dotnetruntimes =
#     (with dotnetCorePackages; combinePackages [ runtime_8_0 runtime_9_0 ]);
# in
buildDotnetGlobalTool {
  pname = "dotnet-script";
  version = "1.6.0";

  dotnet-sdk = dotnetCorePackages.sdk_8_0;
  # dotnet-runtime = dotnetruntimes;

  nugetHash = "sha256-R2z02Orakl6T7nfmNLr3HSbBS2yxFhWRP1imy9B+Tqo=";

  buildInputs = [ dotnetCorePackages.dotnet_8.sdk ];

  # env = { };

  # shellHook = ''
  #   DOTNET_ROOT="${dotnetpkgs}";
  #   PATH="~/.dotnet/tools:$PATH";
  # '';

  meta = {
    description = "A tool to run C# scripts";
    homepage = "https://github.com/dotnet-script/dotnet-script/tree/master";
    license = lib.licenses.mit;
    mainProgram = "dotnet-script";
    # maintainers = with lib.maintainers; [ ];
  };
}
