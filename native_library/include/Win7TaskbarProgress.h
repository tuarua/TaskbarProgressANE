#pragma once

#include <shobjidl.h>
#include <windows.h>
#pragma comment(lib, "Shell32.lib")
#pragma comment(lib, "Ole32.lib")

class Win7TaskbarProgress {
public:
	Win7TaskbarProgress();
	virtual ~Win7TaskbarProgress();

	void SetProgressState(HWND hwnd, TBPFLAG flag);
	void SetProgressValue(HWND hwnd, ULONGLONG ullCompleted, ULONGLONG ullTotal);

private:
	bool Init();
	ITaskbarList3* m_pITaskBarList3;
	bool m_bFailed;
};
