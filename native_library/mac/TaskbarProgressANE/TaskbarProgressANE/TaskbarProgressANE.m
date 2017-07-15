//
// Created by User on 04/12/2016.
// Copyright (c) 2017 Tua Rua Ltd. All rights reserved.
//
#import <Foundation/Foundation.h>

#import "FreMacros.h"
#include "TaskbarProgressANE_oc.h"

#import "TaskbarProgressANE-Swift.h"
#include <Adobe AIR/Adobe AIR.h>

SWIFT_DECL(TRTBP) // use unique prefix throughout to prevent clashes with other ANEs

CONTEXT_INIT(TRTBP) {
    SWIFT_INITS(TRTBP)
    
    /**************************************************************************/
    /******* MAKE SURE TO ADD FUNCTIONS HERE THE SAME AS SWIFT CONTROLLER *****/
    /**************************************************************************/
    static FRENamedFunction extensionFunctions[] =
    {
        MAP_FUNCTION(TRTBP, init)
        ,MAP_FUNCTION(TRTBP, setProgress)
        ,MAP_FUNCTION(TRTBP, setStyle)
    };
    /**************************************************************************/
    /**************************************************************************/
    
    SET_FUNCTIONS
    
}

CONTEXT_FIN(TRTBP) {
    //any clean up code here
}
EXTENSION_INIT(TRTBP)
EXTENSION_FIN(TRTBP)
