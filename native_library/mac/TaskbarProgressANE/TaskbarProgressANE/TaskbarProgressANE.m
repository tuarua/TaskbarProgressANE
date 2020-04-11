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

#import <Foundation/Foundation.h>
#import "FreMacros.h"
#import "TaskbarProgressANE_oc.h"
#import <TaskbarProgressANE/TaskbarProgressANE-Swift.h>

SWIFT_DECL(TRTBP)

CONTEXT_INIT(TRTBP) {
    SWIFT_INITS(TRTBP)
    
    static FRENamedFunction extensionFunctions[] =
    {
         MAP_FUNCTION(TRTBP, init)
        ,MAP_FUNCTION(TRTBP, setProgress)
        ,MAP_FUNCTION(TRTBP, setStyle)
    };
    
    SET_FUNCTIONS
    
}

CONTEXT_FIN(TRTBP) {
    //any clean up code here
}
EXTENSION_INIT(TRTBP)
EXTENSION_FIN(TRTBP)
