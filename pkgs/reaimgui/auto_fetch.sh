#!/usr/bin/env bash

version="v0.9.3.2"
curl -LO https://github.com/cfillion/reaimgui/releases/download/${version}/reaper_imgui-x86_64.so
nix-shell -p cairo libepoxy gtk3 autoPatchelfHook --run "autoPatchelf ./reaper_imgui-x86_64.so"
chmod +x ./reaper_imgui-x86_64.so
mv ./reaper_imgui-x86_64.so ~/.config/REAPER/UserPlugins/
