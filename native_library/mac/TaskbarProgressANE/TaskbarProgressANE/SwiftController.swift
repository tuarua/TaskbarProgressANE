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

public class SwiftController: NSObject {
    public static var TAG = "TaskbarProgressOSXANE"

    public var context: FreContextSwift!
    public var functionsToSet: FREFunctionMap = [:]
    
    var progress: DockProgressBar!
    
    func initController(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        guard argc > 0,
            let style = Int(argv[0])
            else {
                return FreArgError().getError()
        }
        progress = DockProgressBar(frame: NSRect(x: 0, y: 0, width: NSApp.dockTile.size.width, height: 12), style: style)
        return nil
    }
    
    func setProgress(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        guard argc > 0,
            let val = Int(argv[0])
            else {
                return FreArgError().getError()
        }
        
        let asDouble = Double(val)
        progress.updateProgress(progress: asDouble / 100)
        return nil
    }
    
    func setStyle(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        guard argc > 0,
            let style = Int(argv[0])
            else {
                return FreArgError().getError()
        }
        progress.setStyle(style: style)
        return nil
    }
    
}
