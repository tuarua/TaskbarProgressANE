/* Copyright 2017 Tua Rua Ltd.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.*/

import Foundation
import Cocoa
import FreSwift

public class SwiftController: NSObject, FreSwiftMainController {
    public var TAG: String? = "TaskbarProgressOSXANE"

    public var context: FreContextSwift!
    public var functionsToSet: FREFunctionMap = [:]
    
    var progress: DockProgressBar!
    @objc public func getFunctions(prefix: String) -> [String] {
        functionsToSet["\(prefix)init"] = initController
        functionsToSet["\(prefix)setProgress"] = setProgress
        functionsToSet["\(prefix)setStyle"] = setStyle
        
        var arr: [String] = []
        for key in functionsToSet.keys {
            arr.append(key)
        }
        return arr
    }
    
    func initController(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        guard argc > 0,
            let style = Int(argv[0])
            else {
                return ArgCountError(message: "initController").getError(#file, #line, #column)
        }
        progress = DockProgressBar.init(frame: NSRect.init(x: 0, y: 0, width: NSApp.dockTile.size.width, height: 12), style: style)
        return nil
    }
    
    func setProgress(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        guard argc > 0,
            let val = Int(argv[0])
            else {
                return ArgCountError(message: "setProgress").getError(#file, #line, #column)
        }
        
        let asDouble = Double(val)
        progress.updateProgress(progress: asDouble / 100)
        return nil
    }
    
    func setStyle(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        guard argc > 0,
            let style = Int(argv[0])
            else {
                return ArgCountError(message: "setStyle").getError(#file, #line, #column)
        }
        progress.setStyle(style: style)
        return nil
    }
    
    // Must have this function. It exposes the methods to our entry ObjC.
    @objc public func callSwiftFunction(name: String, ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        if let fm = functionsToSet[name] {
            return fm(ctx, argc, argv)
        }
        return nil
    }
    
    @objc public func setFREContext(ctx: FREContext) {
        self.context = FreContextSwift.init(freContext: ctx)
    }
    
    @objc public func onLoad() {
    
    }
}
