//
//  TaskbarProgressANE.swift
//  TaskbarProgressANE
//
//  Created by Eoin Landy on 10/06/2017.
//  Copyright © 2017 Tua Rua Ltd. All rights reserved.
//

import Foundation
import Cocoa


@objc class TaskbarProgressANE: FRESwiftController {
    /*
     /*
     * TBPF_NOPROGRESS	= 0,
     TBPF_INDETERMINATE	= 0x1,
     TBPF_NORMAL	= 0x2,
     TBPF_ERROR	= 0x4,
     TBPF_PAUSED	= 0x8
     */
 */
    
    
    
    var progress:DockProgressBar!
    
    // must have this function !!
    // Must set const numFunctions in WebViewANE.m to the length of this Array
    func getFunctions() -> Array<String> {
        functionsToSet["init"] = initController
        functionsToSet["setProgress"] = setProgress
        functionsToSet["setStyle"] = setStyle
        
        var arr: Array<String> = []
        for key in functionsToSet.keys {
            arr.append(key)
        }
        return arr
    }
    

    func initController(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        guard argc > 0,
            let inFRE0 = argv[0],
            let style = FREObjectSwift.init(freObject: inFRE0).value as? Int
            else {
                traceError(message: "setProgress - incorrect arguments", line: #line, column: #column, file: #file, freError: nil)
                return nil
        }
        progress = DockProgressBar.init(frame: NSMakeRect(0, 0, NSApp.dockTile.size.width, 12), style: style)
        return nil
    }
    
    func setProgress(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        guard argc > 0,
            let inFRE0 = argv[0],
            let val = FREObjectSwift.init(freObject: inFRE0).value as? Int
            else {
                traceError(message: "setProgress - incorrect arguments", line: #line, column: #column, file: #file, freError: nil)
                return nil
        }
        
        let asDouble = Double.init(val)
        progress.updateProgress(progress: asDouble / 100)
        return nil
    }
    
    func setStyle(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        guard argc > 0,
            let inFRE0 = argv[0],
            let style = FREObjectSwift.init(freObject: inFRE0).value as? Int
            else {
                traceError(message: "setProgress - incorrect arguments", line: #line, column: #column, file: #file, freError: nil)
                return nil
        }
        progress.setStyle(style: style)
        return nil
    }
    
    private func traceError(message: String, line: Int, column: Int, file: String, freError: FREError?) {
        trace("ERROR:", "message:", message, "file:", "[\(file):\(line):\(column)]")
        if let freError = freError {
            trace(freError.type)
            trace(freError.stackTrace)
        }
    }
    
    func setFREContext(ctx: FREContext) {
        context = FREContextSwift.init(freContext: ctx)
    }
}
