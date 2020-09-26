## Taskbar Progress ANE

||Normal|Error|Paused |
|---|---|---|---|
|Windows|  ![alt tag](https://raw.githubusercontent.com/tuarua/TaskbarProgressANE/master/screenshots/capture-normal.png) | ![alt tag](https://raw.githubusercontent.com/tuarua/TaskbarProgressANE/master/screenshots/capture-error.png)  | ![alt tag](https://raw.githubusercontent.com/tuarua/TaskbarProgressANE/master/screenshots/capture-paused.png)  |
|macOS|  ![alt tag](https://raw.githubusercontent.com/tuarua/TaskbarProgressANE/master/screenshots/capture-normal-osx.png) | ![alt tag](https://raw.githubusercontent.com/tuarua/TaskbarProgressANE/master/screenshots/capture-error-osx.png)  | ![alt tag](https://raw.githubusercontent.com/tuarua/TaskbarProgressANE/master/screenshots/capture-paused-osx.png)  |

-------------

## Prerequisites

You will need:

- macOS 10.14 (Mojave) or greater
- IntelliJ IDEA
- AIR 33.1.1.217+
- [.Net Core Runtime](https://dotnet.microsoft.com/download/dotnet-core/3.1)
- [AIR-Tools](https://github.com/tuarua/AIR-Tools/)

##### The ANE + Dependencies
 
Change directory into the _example_ folder eg

```bash
cd /MyMac/dev/AIR/DarkMode-ANE/example
```

Run the _"air-tools"_ command (You will need [AIR-Tools](https://github.com/tuarua/AIR-Tools/) installed)

```bash
air-tools install
```


**NEW** This tool now: 

1. Downloads the ANE and dependencies.
1. Applies all required Android Manifest, InfoAdditons and Entitlements to your app.xml. See air package.json

-------------

* This ANE was built with MS Visual Studio 2015. As such your machine (and user's machines) will need to have Microsoft Visual C++ 2015 Redistributable (x86) runtime installed.
https://www.microsoft.com/en-us/download/details.aspx?id=48145

* This ANE also uses .NET 4.6 Framework.
