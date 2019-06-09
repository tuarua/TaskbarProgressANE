#include "TaskbarProgressANE.h"
#include "FreSharpBridge.h"

extern "C" {
	CONTEXT_INIT(TRTBP) {
		FREBRIDGE_INIT

		static FRENamedFunction extensionFunctions[] = {
			 MAP_FUNCTION(init)
			,MAP_FUNCTION(setProgress)
			,MAP_FUNCTION(setStyle)
		};

		SET_FUNCTIONS
	}

	CONTEXT_FIN(TRTBP) {
		FreSharpBridge::GetController()->OnFinalize();
	}
	EXTENSION_INIT(TRTBP)
	EXTENSION_FIN(TRTBP)

}

