#!/bin/sh
FreSharpVersion="2.3.0"
FreSwiftVersion="2.3.0"

wget -O ../native_extension/ane/FreSwift.ane https://github.com/tuarua/Swift-IOS-ANE/releases/download/${FreSwiftVersion}/FreSwift.ane?raw=true
wget -O ../native_extension/ane/FreSharp.ane https://github.com/tuarua/FreSharp/releases/download/${FreSharpVersion}/FreSharp.ane?raw=true
