## Taskbar Progress ANE

||Normal|Error|Paused |
|---|---|---|---|
|Windows|  ![alt tag](https://raw.githubusercontent.com/tuarua/TaskbarProgressANE/master/screenshots/capture-normal.png) | ![alt tag](https://raw.githubusercontent.com/tuarua/TaskbarProgressANE/master/screenshots/capture-error.png)  | ![alt tag](https://raw.githubusercontent.com/tuarua/TaskbarProgressANE/master/screenshots/capture-paused.png)  |
|macOS|  ![alt tag](https://raw.githubusercontent.com/tuarua/TaskbarProgressANE/master/screenshots/capture-normal-osx.png) | ![alt tag](https://raw.githubusercontent.com/tuarua/TaskbarProgressANE/master/screenshots/capture-error-osx.png)  | ![alt tag](https://raw.githubusercontent.com/tuarua/TaskbarProgressANE/master/screenshots/capture-paused-osx.png)  |

##### Dependencies
From the command line cd into /example and run:
- macOS
```shell
bash get_dependencies.sh
```
- Windows Powershell
```shell
get_dependencies.ps1
```

##### Windows Installation - Important!
The C# binaries(dlls) are now packaged inside the ANE. All of these **need to be deleted** from your AIRSDK.     
FreSharp.ane is now a required dependency for Windows. 

* This ANE was built with MS Visual Studio 2015. As such your machine (and user's machines) will need to have Microsoft Visual C++ 2015 Redistributable (x86) runtime installed.
https://www.microsoft.com/en-us/download/details.aspx?id=48145

* This ANE also uses .NET 4.6 Framework.
