$FreSharpVersion = "2.2.0"

$currentDir = (Get-Item -Path ".\" -Verbose).FullName
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri https://github.com/tuarua/Swift-IOS-ANE/releases/download/3.1.0/FreSwift.ane?raw=true -OutFile "$currentDir\..\native_extension\ane\FreSwift.ane"
Invoke-WebRequest -Uri https://github.com/tuarua/FreSharp/releases/download/$FreSharpVersion/FreSharp.ane?raw=true -OutFile "$currentDir\..\native_extension\ane\FreSharp.ane"
