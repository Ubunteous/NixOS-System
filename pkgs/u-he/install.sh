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

if [ $PLUGIN == "zebra-legacy" ]; then 
    SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

    (cd ./build/lib/*/01*/Zebra2-* && \
	 nix-shell $SCRIPT_DIR/shell.nix --run "./install.sh --quiet")

    (cd ./build/lib/*/02*/ZebraHZ-* && \
	 nix-shell $SCRIPT_DIR/shell.nix --run "./install.sh --quiet")

    mv -vn ./build/lib/*/03* ~/Downloads/
    
    echo "Zebra2 and ZebraHZ installed. Soundsets moved to ~/Downloads/"
else
    nix-shell ./shell.nix --run "./build/lib/install.sh --quiet"
fi

rm -r result
rm -r build
