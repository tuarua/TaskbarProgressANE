//
//  TaskbarProgressANE.m
//  TaskbarProgressANE
//
//  Created by Eoin Landy on 10/06/2017.
//  Copyright © 2017 Tua Rua Ltd. All rights reserved.
//


#import <Foundation/Foundation.h>
#include "TaskbarProgressANE_oc.h"
#import "TaskbarProgressANE-Swift.h"
#import <FreSwift/FlashRuntimeExtensions.h>

TaskbarProgressANE *swft; // our main Swift Controller
NSArray * funcArray;
#define FRE_FUNCTION(fn) FREObject (fn)(FREContext context, void* functionData, uint32_t argc, FREObject argv[])

FRE_FUNCTION(callSwiftFunction) {
    NSString* fName = (__bridge NSString *)(functionData);
    return [swft callSwiftFunctionWithName:fName ctx:context argc:argc argv:argv];
}


void contextInitializer(void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFunctionsToSet,
                        const FRENamedFunction **functionsToSet) {
    
    swft = [[TaskbarProgressANE alloc] init];
    [swft setFREContextWithCtx:ctx];
    
    funcArray = [swft getFunctions];
    /**************************************************************************/
    /********************* DO NO MODIFY ABOVE THIS LINE ***********************/
    /**************************************************************************/
    
    /******* MAKE SURE TO ADD FUNCTIONS HERE THE SAME AS SWIFT CONTROLLER *****/
    /**************************************************************************/
    static FRENamedFunction extensionFunctions[] =
    {
        { (const uint8_t*) "init", (__bridge void *)@"init", &callSwiftFunction }
        ,{ (const uint8_t*) "setProgress", (__bridge void *)@"setProgress", &callSwiftFunction }
        ,{ (const uint8_t*) "setStyle", (__bridge void *)@"setStyle", &callSwiftFunction }
    };
    /**************************************************************************/
    /**************************************************************************/
    
    
    *numFunctionsToSet = sizeof(extensionFunctions) / sizeof(FRENamedFunction);
    *functionsToSet = extensionFunctions;
    
}

void contextFinalizer(FREContext ctx) {
    return;
}

void TRTBPExtInizer(void **extData, FREContextInitializer *ctxInitializer, FREContextFinalizer *ctxFinalizer) {
    *ctxInitializer = &contextInitializer;
    *ctxFinalizer = &contextFinalizer;
}

void TRTBPExtFinizer(void *extData) {
    FREContext nullCTX;
    nullCTX = 0;
    contextFinalizer(nullCTX);
    return;
}

