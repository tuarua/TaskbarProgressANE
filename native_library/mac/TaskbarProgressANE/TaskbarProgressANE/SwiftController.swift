//
//  TaskbarProgressANE.swift
//  TaskbarProgressANE
//
//  Created by Eoin Landy on 10/06/2017.
//  Copyright © 2017 Tua Rua Ltd. All rights reserved.
//

import Foundation
import Cocoa
import FreSwift

@objc class SwiftController: FreSwiftController {
    private var context: FreContextSwift!
    private func trace(_ value: Any...){
        freTrace(ctx: context, value: value)
    }
    
    var progress:DockProgressBar!
    public func getFunctions(prefix: String) -> Array<String> {
        functionsToSet["\(prefix)init"] = initController
        functionsToSet["\(prefix)setProgress"] = setProgress
        functionsToSet["\(prefix)setStyle"] = setStyle
        
        var arr: Array<String> = []
        for key in functionsToSet.keys {
            arr.append(key)
        }
        return arr
    }
    

    func initController(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        guard argc > 0,
            let inFRE0 = argv[0],
            let style = FreObjectSwift.init(freObject: inFRE0).value as? Int
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
            let val = FreObjectSwift.init(freObject: inFRE0).value as? Int
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
            let style = FreObjectSwift.init(freObject: inFRE0).value as? Int
            else {
                traceError(message: "setProgress - incorrect arguments", line: #line, column: #column, file: #file, freError: nil)
                return nil
        }
        progress.setStyle(style: style)
        return nil
    }
    
    private func traceError(message: String, line: Int, column: Int, file: String, freError: FreError?) {
        trace("ERROR:", "message:", message, "file:", "[\(file):\(line):\(column)]")
        if let freError = freError {
            trace(freError.type)
            trace(freError.stackTrace)
        }
    }
    
    public func setFREContext(ctx: FREContext) {
        context = FreContextSwift.init(freContext: ctx)
    }
}
