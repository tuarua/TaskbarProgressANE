//
//  TaskbarProgressANE_oc.h
//  TaskbarProgressANE
//
//  Created by Eoin Landy on 10/06/2017.
//  Copyright © 2017 Tua Rua Ltd. All rights reserved.
//

#ifndef TaskbarProgressANE_oc_h
#define TaskbarProgressANE_oc_h
#import <Cocoa/Cocoa.h>
#include <Adobe AIR/Adobe AIR.h>

#define EXPORT __attribute__((visibility("default")))

EXPORT
void TRTBPExtInizer(void **extData, FREContextInitializer *ctxInitializer, FREContextFinalizer *ctxFinalizer);

EXPORT
void TRTBPExtFinizer(void *extData);
#endif /* TaskbarProgressANE_oc_h */


