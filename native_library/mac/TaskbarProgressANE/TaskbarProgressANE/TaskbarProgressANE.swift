//
//  TaskbarProgressANE.swift
//  TaskbarProgressANE
//
//  Created by Eoin Landy on 10/06/2017.
//  Copyright © 2017 Tua Rua Ltd. All rights reserved.
//

import Foundation



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
        return nil
    }
    
    func setProgress(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        return nil
    }
    
    func setStyle(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        return nil
    }
    
    func setFREContext(ctx: FREContext) {
        context = FREContextSwift.init(freContext: ctx)
    }
}
