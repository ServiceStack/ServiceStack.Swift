#!/bin/sh
cd ${0%/*}
rm -Rf ServiceStackXcode.dmg
rm -Rf ServiceStackXcode.xcplugin
cp -R "${HOME}/Library/Application Support/Developer/Shared/Xcode/Plug-ins/ServiceStackXCode.xcplugin" ./
/usr/local/bin/appdmg pkg.json ServiceStackXcode.dmg
rm -Rf ../../dist/ServiceStackXcode.dmg
cp -R ./ServiceStackXcode.dmg ../../dist/