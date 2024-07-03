#Include WindowsDataTypes.ahk
class StructAhk extends Buffer {

    __Init() {
        this.Offset := [ 0 ]
        this.SizeT := []
        this.Size := 0
        this.Members := []
        this.AkhType := []
        this.Values := []
    }
    __New( Members, Values, CallBack := 0 , IndexSize := 0 ) {

        if ( Type( Values ) == "VarRef" )  {
            MsgBox( Type( Values ) )
        }

        Members := RegExReplace( Members, "(;\s*|\s+)", " " )
        Members := StrSplit( Trim( Members ), A_Space )

        iCount := 0
        Loop Members.Length {

            if ( Mod( A_Index, 2 ) = 1 ) {

                ++iCount
                if ( iCount > 1 ) {
                    this.Offset.Push( this.Size )
                    MsgBox this.Size
                }
                ;Verificar se o tipo esta lista
                ;Caso exista pMember é diferente de zero
                data := WindowsDataTypes( Members[ A_Index ] )
                if ( Type( data ) == "Array" ) {
                    
                    if ( !this.IsArray( &Members, pMember, &iCount) ) {

                    }
                }
            }
        }
    }
}