#include "TaskbarProgressANE.h"
#include <windows.h>
#include "Win7TaskbarProgress.h"

DWORD air_windowID;
HWND air_windowHandle;
FREContext dllContext;
Win7TaskbarProgress wp;

extern "C" {
#define FRE_FUNCTION(fn) FREObject (fn)(FREContext context, void* functionData, uint32_t argc, FREObject argv[])

	BOOL CALLBACK EnumProc(HWND hwnd, LPARAM lParam) {
		GetWindowThreadProcessId(hwnd, &air_windowID);
		if (air_windowID == lParam)
		{
			air_windowHandle = hwnd;
			return false;
		}
		return true;
	}

	FRE_FUNCTION(init) {
		wp = Win7TaskbarProgress();
		/*
		 * TBPF_NOPROGRESS	= 0,
        TBPF_INDETERMINATE	= 0x1,
        TBPF_NORMAL	= 0x2,
        TBPF_ERROR	= 0x4,
        TBPF_PAUSED	= 0x8
		 */
		auto freObject = argv[0];
		auto result = 0;
		auto status = FREGetObjectAsInt32(freObject, &result);
		if (FRE_OK == status)
			wp.SetProgressState(air_windowHandle, static_cast<TBPFLAG>(result));

		return nullptr;
	}

	FRE_FUNCTION(setProgress) {
		auto freObject = argv[0];
		auto result = 0;
		auto status = FREGetObjectAsInt32(freObject, &result);
		if (FRE_OK == status)
			wp.SetProgressValue(air_windowHandle, result, 100);
		if(result >= 100)
			wp.SetProgressState(air_windowHandle, TBPF_NOPROGRESS);
		return nullptr;
	}

	FRE_FUNCTION(setStyle) {
		auto freObject = argv[0];
		auto result = 0;
		auto status = FREGetObjectAsInt32(freObject, &result);
		if (FRE_OK == status)
			wp.SetProgressState(air_windowHandle, static_cast<TBPFLAG>(result));
		return nullptr;
	}

	void contextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet) {
		auto processID = GetCurrentProcessId();
		EnumWindows(EnumProc, processID);

		static FRENamedFunction extensionFunctions[] = {
			 {reinterpret_cast<const uint8_t *>("init"), nullptr, &init}
			,{reinterpret_cast<const uint8_t *>("setProgress"), nullptr, &setProgress}
			,{ reinterpret_cast<const uint8_t *>("setStyle"), nullptr, &setStyle }
		};

		*numFunctionsToSet = sizeof(extensionFunctions) / sizeof(FRENamedFunction);
		*functionsToSet = extensionFunctions;
		dllContext = ctx;
	}


	void contextFinalizer(FREContext ctx) { }

	void TRTBPExtInizer(void** extData, FREContextInitializer* ctxInitializer, FREContextFinalizer* ctxFinalizer) {
		*ctxInitializer = &contextInitializer;
		*ctxFinalizer = &contextFinalizer;
	}

	void TRTBPExtFinizer(void* extData) {
		wp.~Win7TaskbarProgress();
		contextFinalizer(nullptr);
	}
}
