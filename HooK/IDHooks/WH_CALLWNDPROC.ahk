/************************************************************************
 * @description Instala um procedimento de gancho que monitora mensagens antes que o sistema as envie para o procedimento de janela de destino. Para obter mais informações, consulte o procedimento de gancho CallWndProc
 * @file WH_CALLWNDPROC.ahk
 * @author 
 * @date 2024/07/01
 * @version 0.0.0
 ***********************************************************************/
WH_CALLWNDPROC( Value := "Int", test := 0 ) {
    if ( test ) {
        if test = 1
            Goto( "Teste1" )
        else if test = 2
            Goto( "Teste2" )
    }

    Int := 4
    Hex := "0x2"

    if ( Value = "Hex" ) {
        return Hex
    }
    return Int

    Teste1:
        Values := 4
        if ( WH_CALLWNDPROC() == Values ) {
            MsgBox( true )
        }
    Teste2:
        Values := "0x2"
        if ( WH_CALLWNDPROC( "Hex") == Values ) {
            MsgBox( true )
        }

}