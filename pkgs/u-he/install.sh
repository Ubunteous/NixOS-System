#!/usr/bin/env bash

if [[ $# -ne 1 || "$1" == "-h" || "$1" == "--help" ]]; then
    echo "Usage: install.sh [plugin name]"
    exit 1
fi

PLUGIN=$1
plugins=(
    "ace"
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
    "zebralette3"
	"zebra-cm"
	"bazille-cm"
)

if [[ ! " ${plugins[@]} " =~ " $PLUGIN " ]]; then
	echo "Plugin \"${PLUGIN}\" not recognised. Use one of these instead:"

	for plugin in "${plugins[@]}"; do
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
