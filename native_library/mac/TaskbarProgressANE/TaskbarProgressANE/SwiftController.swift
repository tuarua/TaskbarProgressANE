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

public class SwiftController: NSObject, FreSwiftMainController {
    public var TAG: String? = "TaskbarProgressOSXANE"

    public var context: FreContextSwift!
    public var functionsToSet: FREFunctionMap = [:]
    
    var progress:DockProgressBar!
    @objc public func getFunctions(prefix: String) -> Array<String> {
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
            let style = Int(argv[0])
            else {
                return ArgCountError(message: "initController").getError(#file, #line, #column)
        }
        progress = DockProgressBar.init(frame: NSMakeRect(0, 0, NSApp.dockTile.size.width, 12), style: style)
        return nil
    }
    
    func setProgress(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        guard argc > 0,
            let val = Int(argv[0])
            else {
                return ArgCountError(message: "setProgress").getError(#file, #line, #column)
        }
        
        let asDouble = Double.init(val)
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
