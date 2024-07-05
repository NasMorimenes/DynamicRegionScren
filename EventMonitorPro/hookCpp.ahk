
Hex := 
(
    "574d5f4b4559444f574e20696e204368726f6d65534883ec30b901000000488d5c244848895424484c894424504c894"
    "c245848895c2428ff15000000004989d8488d15000000004889c1e8000000004883c4305bc34368726f6d655f576964"
    "67657457696e5f310000000066662e0f1f8400000000000f1f400041545756534881ec280100004189cc4889d64c89c"
    "385c97869498b48184885c97460488d7c242041b8000100004889faff150000000048ba696467657457696e48335424"
    "2848b84368726f6d655f5748334424204809c2752966817c24305f317520807c2432007519817b10000100007510488"
    "b5308488d0d00000000e82effffff488b0d080000004989d94989f04489e24881c4280100005b5e5f415c48ff250000"
    "0000909090909090909090909000000000000000000000000000000000"
)

CapMyfunc := StrLen( Hex ) // 2
MyFunc := Buffer( capMyFunc, 0 )

Loop CapMyfunc {
	;MsgBox Value := "0x" SubStr( Hex, 2 * A_Index - 1, 2 )
	NumPut( "UChar", ( Value := "0x" SubStr( Hex, 2 * A_Index - 1, 2 ) ), MyFunc, A_Index-1 )
}

DllCall( "VirtualProtect"
			   , "Ptr"		,  MyFunc.Ptr
			   , "Ptr"		,   CapMyfunc
			   , "Uint",		0x40
			   , "UInt*",		   0 )

/*
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