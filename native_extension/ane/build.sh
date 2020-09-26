#!/bin/sh

#Get the path to the script and trim to get the directory.
echo "Setting path to current directory to:"
pathtome=$0
pathtome="${pathtome%/*}"
echo $pathtome

PROJECTNAME=TaskbarProgressANE

AIR_SDK="/Users/eoinlandy/SDKs/AIRSDK_33"
echo $AIR_SDK

#Setup the directory.
echo "Making directories."

if [ ! -d "$pathtome/platforms" ]; then
mkdir "$pathtome/platforms"
fi

if [ -d "$pathtome/platforms/mac" ]; then
rm -r "$pathtome/platforms/mac"
fi

if [ ! -d "$pathtome/platforms/mac" ]; then
mkdir "$pathtome/platforms/mac"
mkdir "$pathtome/platforms/mac/release"
fi

if [ ! -d "$pathtome/platforms/win" ]; then
mkdir "$pathtome/platforms/win"
mkdir "$pathtome/platforms/win/release"
fi

#Copy SWC into place.
echo "Copying SWC into place."
cp "$pathtome/../bin/$PROJECTNAME.swc" "$pathtome/"

#Extract contents of SWC.
echo "Extracting files form SWC."
unzip "$pathtome/$PROJECTNAME.swc" "library.swf" -d "$pathtome"

#Copy library.swf to folders.
echo "Copying library.swf into place."
cp "$pathtome/library.swf" "$pathtome/platforms/mac/release"
cp "$pathtome/library.swf" "$pathtome/platforms/win/x86/release"
cp "$pathtome/library.swf" "$pathtome/platforms/win/x64/release"

#Copy native libraries into place.
echo "Copying native libraries into place."

#Copy native libraries into place.
echo "Copying native libraries into place."
cp -R -L "$pathtome/../../native_library/mac/$PROJECTNAME/Build/Products/Release/$PROJECTNAME.framework" "$pathtome/platforms/mac/release"
rm -r "$pathtome/platforms/mac/release/$PROJECTNAME.framework/Versions"


#Run the build command.
echo "Building Release."
"$AIR_SDK"/bin/adt -package \
-target ane "$pathtome/$PROJECTNAME.ane" "$pathtome/extension.xml" \
-swc "$pathtome/$PROJECTNAME.swc" \
-platform MacOS-x86-64 -C "$pathtome/platforms/mac/release" $PROJECTNAME.framework library.swf \
-platform Windows-x86 -C "$pathtome/platforms/win/x86/release" ${PROJECTNAME}.dll ${PROJECTNAME}Lib.dll library.swf \
-platform Windows-x86-64 -C "$pathtome/platforms/win/x64/release" ${PROJECTNAME}.dll ${PROJECTNAME}Lib.dll library.swf 

zip "$pathtome/$PROJECTNAME.ane" -u "air_package.json"
cp "$pathtome/$PROJECTNAME.ane" "$pathtome/../../example/extensions/$PROJECTNAME.ane"

#rm -r "$pathtome/platforms/mac"
rm "$pathtome/$PROJECTNAME.swc"
rm "$pathtome/library.swf"
