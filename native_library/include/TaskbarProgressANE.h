#pragma once
#include "FlashRuntimeExtensions.h"

extern "C" {
	__declspec(dllexport) void TRTBPExtInizer(void** extData, FREContextInitializer* ctxInitializer, FREContextFinalizer* ctxFinalizer);
	__declspec(dllexport) void TRTBPExtFinizer(void* extData);
}
