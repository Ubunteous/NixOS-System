#!/usr/bin/env bash

if [[ $# -ne 1 || "$1" == "-h" || "$1" == "--help" ]]; then
    echo "Usage: install.sh [plugin name]"
    exit 1
fi

PLUGIN=$1
declare -A plugins=(
    ["ace"]="ace"
    ["bazille"]="bazille"
    ["colourcopy"]="colourcopy"
    ["diva"]="diva"
    ["filterscape"]="filterscape"
    ["hive"]="hive"
    ["hive"]="hive"
    ["mfm2"]="mfm2"
    ["podolski"]="podolski"
    ["presswerk"]="presswerk"
    ["repro"]="repro"
    ["satin"]="satin"
    ["triple-cheese"]="triple-cheese"
    ["twangstrom"]="twangstrom"
    ["tyrell"]="tyrell"
    ["uhbik"]="uhbik"
    ["zebra-legacy"]="zebra-legacy"
    ["zebralette3"]="zebralette3"
)

if [ ! -v plugins[$PLUGIN] ]; then
    echo "Plugin \"${PLUGIN}\" not recognised. Use one of these instead:"

    options=("ace"
	     "bazille"
	     "colourcopy"
	     "diva"
	     "filterscape"
	     "hive"
	     "mfm2"
	     "podolski"
	     "presswerk"
	     "repro"
	     "satin"
	     "triple-cheese"
	     "twangstrom"
	     "tyrell"
	     "uhbik"
	     "zebra-legacy"
	     "zebralette3")
    
    for plugin in "${options[@]}"; do
	echo "=> $plugin"
    done

    exit 1
fi

nix-build -A "$PLUGIN"
cp -r result/ build
chmod -R +w build

# annoying to deal with. maybe do it later
if [ $PLUGIN == "zebra-legacy" ]; then
    mkdir -p ~/Downloads/zebra/
    mv build/lib/* ~/Downloads/zebra/
    rm -r result
    rm -r build

    echo "I have not finished configuring this plugin's installation. Files moved to ~/Downloads/zebra"
    exit 0
fi

# nix-shell -p glib gtk3 --run ./build/lib/install.sh
nix-shell ./shell.nix --run "./build/lib/install.sh --quiet"
rm -r result
rm -r build
