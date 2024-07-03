;(https://learn.microsoft.com/pt-br/windows/win32/api/winuser/ns-winuser-cwpstruct)
sintaxe := 
(
    "typedef struct tagCWPSTRUCT {
        LPARAM lParam;
        WPARAM wParam;
        UINT   message;
        HWND   hwnd;
    } CWPSTRUCT, *PCWPSTRUCT, *NPCWPSTRUCT, *LPCWPSTRUCT;"
)