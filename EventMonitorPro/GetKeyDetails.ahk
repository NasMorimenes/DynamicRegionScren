; Utility Function to Get Key Details
/**
 * typedef struct tagKBDLLHOOKSTRUCT {\
 * DWORD     vkCode;\
  DWORD     scanCode;\
  DWORD     flags;\
  DWORD     time;\
  ULONG_PTR dwExtraInfo;\
} KBDLLHOOKSTRUCT, *LPKBDLLHOOKSTRUCT, *PKBDLLHOOKSTRUCT;\
 * @param lParam 
 * @returns {String} 
 */
GetKeyDetails( lParam ) {

    vkCode := NumGet( lParam, 0, "Int" )
    scCode := NumGet(lParam, 4, "Int" )
    extended := NumGet(lParam, 8, "Int" ) & 1
    time := NumGet(lParam, 12, "Int" )

    Detail :=
    (
        "vkCode: " vkCode
        " scCode: " scCode
        " Extended: " extended
        " Time: " time
    )

    return Detail
}
/*

; Utility Function to Get Key Details
GetKeyDetails(lParam)
{
    vkCode := NumGet(lParam + 0, 0)
    scCode := NumGet(lParam + 0, 4)
    extended := NumGet(lParam + 0, 8) & 1
    time := NumGet(lParam + 0, 12)
    return "vkCode: " . vkCode . " scCode: " . scCode . " Extended: " . extended . " Time: " . time
}