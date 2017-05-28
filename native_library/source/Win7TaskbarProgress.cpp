#include "stdafx.h"
#include "Win7TaskbarProgress.h"


Win7TaskbarProgress::Win7TaskbarProgress() {
	m_pITaskBarList3 = nullptr;
	m_bFailed = false;
}

Win7TaskbarProgress::~Win7TaskbarProgress() {
	if (m_pITaskBarList3)
	{
		m_pITaskBarList3->Release();
		CoUninitialize();
	}
}

void Win7TaskbarProgress::SetProgressState(HWND hwnd, TBPFLAG flag) {
	if (Init())
		m_pITaskBarList3->SetProgressState(hwnd, flag);
}

void Win7TaskbarProgress::SetProgressValue(HWND hwnd, ULONGLONG ullCompleted, ULONGLONG ullTotal) {
	if (Init())
		m_pITaskBarList3->SetProgressValue(hwnd, ullCompleted, ullTotal);
}

bool Win7TaskbarProgress::Init() {
	if (m_pITaskBarList3)
		return true;

	if (m_bFailed)
		return false;

	// Initialize COM for this thread...
	CoInitialize(nullptr);

	CoCreateInstance(CLSID_TaskbarList, nullptr, CLSCTX_INPROC_SERVER, IID_ITaskbarList3, reinterpret_cast<void **>(&m_pITaskBarList3));

	if (m_pITaskBarList3)
		return true;

	m_bFailed = true;
	CoUninitialize();
	return false;
}
