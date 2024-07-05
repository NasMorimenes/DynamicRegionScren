#include <windows.h>
#include <stdio.h>

HHOOK hHook = NULL;
HINSTANCE hInstance = NULL;

LRESULT CALLBACK CallWndProc(int nCode, WPARAM wParam, LPARAM lParam)
{
    if (nCode >= 0)
    {
        CWPSTRUCT *pCWP = (CWPSTRUCT *)lParam;
        if (pCWP->hwnd)
        {
            char className[256];
            GetClassNameA(pCWP->hwnd, className, sizeof(className));
            if (strcmp(className, "Chrome_WidgetWin_1") == 0)
            {
                // Processar mensagens de janelas do Chrome
                if (pCWP->message == WM_KEYDOWN)
                {
                    printf("WM_KEYDOWN in Chrome: %d\n", pCWP->wParam);
                }
                // Adicione mais processamento de mensagens aqui
            }
        }
    }
    return CallNextHookEx(hHook, nCode, wParam, lParam);
}

extern "C" __declspec(dllexport) void SetHook()
{
    if (!hHook)
    {
        hHook = SetWindowsHookEx(WH_CALLWNDPROC, CallWndProc, hInstance, 0);
    }
}

extern "C" __declspec(dllexport) void RemoveHook()
{
    if (hHook)
    {
        UnhookWindowsHookEx(hHook);
        hHook = NULL;
    }
}

BOOL APIENTRY DllMain(HMODULE hModule, DWORD ul_reason_for_call, LPVOID lpReserved)
{
    switch (ul_reason_for_call)
    {
    case DLL_PROCESS_ATTACH:
        hInstance = hModule;
        break;
    case DLL_PROCESS_DETACH:
        RemoveHook();
        break;
    }
    return TRUE;
}
