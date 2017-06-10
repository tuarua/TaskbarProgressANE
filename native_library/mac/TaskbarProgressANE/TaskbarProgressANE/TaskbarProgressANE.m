//
//  TaskbarProgressANE.m
//  TaskbarProgressANE
//
//  Created by Eoin Landy on 10/06/2017.
//  Copyright © 2017 Tua Rua Ltd. All rights reserved.
//


#import "TaskbarProgressANE_oc.h"

#import <Foundation/Foundation.h>
#include "TaskbarProgressANE_oc.h"
#import "TaskbarProgressANE-Swift.h"
#include <Adobe AIR/Adobe AIR.h>

TaskbarProgressANE *swft; // our main Swift Controller
NSArray * funcArray;
#define FRE_FUNCTION(fn) FREObject (fn)(FREContext context, void* functionData, uint32_t argc, FREObject argv[])

FRE_FUNCTION(callSwiftFunction) {
    NSString* fName = (__bridge NSString *)(functionData);
    return [swft callSwiftFunctionWithName:fName ctx:context argc:argc argv:argv];
}


void contextInitializer(void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFunctionsToSet,
                        const FRENamedFunction **functionsToSet) {
    
    /******* MAKE SURE TO SET NUM OF FUNCTIONS MANUALLY *****/
    /********************************************************/
    
    const int numFunctions = 3;
    
    /********************************************************/
    /********************************************************/
    
    
    swft = [[TaskbarProgressANE alloc] init];
    [swft setFREContextWithCtx:ctx];
    
    funcArray = [swft getFunctions];
    static FRENamedFunction extensionFunctions[numFunctions] = {};
    for (int i = 0; i < [funcArray count]; ++i) {
        NSString * nme = [funcArray objectAtIndex:i];
        FRENamedFunction nf = {(const uint8_t *) [nme UTF8String], (__bridge void *)(nme), &callSwiftFunction};
        extensionFunctions[i] = nf;
    }
    
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

