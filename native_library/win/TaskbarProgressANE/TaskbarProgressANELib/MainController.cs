#region License

// Copyright 2017 Tua Rua Ltd.
// 
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
// 
//  http://www.apache.org/licenses/LICENSE-2.0
// 
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
// 
//  All Rights Reserved. Tua Rua Ltd.

#endregion

using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using TuaRua.FreSharp;
using FREObject = System.IntPtr;
using FREContext = System.IntPtr;
using Hwnd = System.IntPtr;

// ReSharper disable UnusedMember.Global

namespace TaskbarProgressLib {
    public class MainController : FreSharpMainController {
        private Hwnd _airWindow;

        public string[] GetFunctions() {
            FunctionsDict =
                new Dictionary<string, Func<FREObject, uint, FREObject[], FREObject>> {
                     {"init", InitController}
                    ,{"setProgress", SetProgress}
                    ,{"setStyle", SetStyle}
                };
            return FunctionsDict.Select(kvp => kvp.Key).ToArray();
        }

        private FREObject InitController(FREContext ctx, uint argc, FREObject[] argv) {
            var style = (TaskbarProgress.TaskbarStates) argv[0].AsInt();
            _airWindow = Process.GetCurrentProcess().MainWindowHandle;
            FreSharpLogger.GetInstance().Context = Context;
            TaskbarProgress.SetState(_airWindow, style);
            return FREObject.Zero;
        }

        private FREObject SetStyle(FREContext ctx, uint argc, FREObject[] argv) {
            if (argv[0] == FREObject.Zero) return FREObject.Zero;
            var style = (TaskbarProgress.TaskbarStates) argv[0].AsInt();
            TaskbarProgress.SetState(_airWindow, style);
            return FREObject.Zero;
        }

        private FREObject SetProgress(FREContext ctx, uint argc, FREObject[] argv) {
            if (argv[0] == FREObject.Zero) return FREObject.Zero;
            var progress = argv[0].AsInt();
            TaskbarProgress.SetValue(_airWindow, progress, 100);
            if (progress >= 100) {
                TaskbarProgress.SetState(_airWindow, TaskbarProgress.TaskbarStates.NoProgress);
            }
            return FREObject.Zero;
        }

        public override void OnFinalize() { }
        public override string TAG => "MainController";
    }
}