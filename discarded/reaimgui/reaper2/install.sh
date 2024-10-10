#!/usr/bin/env bash

binary="reaper_imgui-x86_64.so"

nix-build -A "reaimgui"
cp -r result/ build
chmod -R +w build
# rm -r result
# rm -r build
