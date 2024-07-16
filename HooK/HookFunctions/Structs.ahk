#Include WindowsDataTypes.ahk

Members :=
(
    "DWORD cdg[10];
    RECT  rcMonitor;"
)

Callback := CallbackCreate( RECT, , 2 )

RECT( a, b ) {
    a := StrGet( a )
    dss := StructAhk( a, b )
    return ObjPtr( dss )
}
;    RECT  rcWork;
;    DWORD dwFlags;
;    WCHAR szDevice[CCHDEVICENAME];"
;)

Ads := [ 0 ]
Ass := StructAhk( Members, Ads, Callback )

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
/*
                if ( data ) {
                    ; Verifica se é uma array
                    ;temp := Members[ A_Index + 1 ]                    
                    if ( !this.IsArray( &Members, pMember, &iCount) ) {

                        this.AkhType.Push( WindowsDataTypes( Members[ A_Index ], 1 ) )
                        this.Members.Push( Members[ A_Index + 1 ] )
                        this.Size += WindowsDataTypes( Members[ A_Index ] )
                    }
                    ;this.SizeT.Push( pMember )
                    ;this.AkhType.Push( WindowsDataTypes( Members[ A_Index ], 1 ) )
                }
                else {
                    ;Members[ A_Index ]
                    Member := "LONG left; LONG top; LONG right LONG bottom;"
                    Values := 0
                    if ( CallBack ) {
                        ObjTemp :=
                        DllCall(
                            CallBack,
                            "Str",Member,
                            "Int", 0,
                            "Ptr"
                        )
                        CallbackFree( CallBack )
                        ObjFromPtrAddRef( ObjTemp )

                    }
                    ;.LocateStructs("casa")
                }

                this.AkhType.Push( WindowsDataTypes( Members[ A_Index ], 1 ) )
                this.Members.Push( Members[ A_Index + 1 ] )
                this.Size += WindowsDataTypes( Members[ A_Index ] )
                if ( !IsObject( Values ) ) {
                    this.Values.Push( 0 )
                }
                else {
                    this.Values.Push( Values[ iCount ] )
                }

            }
        }
        if ( IndexSize ) {
            if ( Values[ IndexSize ] == 0 ) {
                this.Values[ IndexSize ] := this.Size
            }
            else {
                Throw( "Erro 01")
            }
        }
        super.__New( this.Size, 0 )
        this.SetValuesInMemory(  )
    }
    SetValuesInMemory( pointer := 0 ) {

        if ( pointer ) {
            MsgBox( "NoImplemted" )
        }
        else if ( pointer = 0 ) {
            for i, j in this.Offset {
                NumPut( this.AkhType[ i ], this.Values[ i ], this.Ptr, j )
            }
        }
    }
    GetValuesByOffiset(  ) {

    }

    IsArray( &Members, sizeMember, &Count ) {
        ; Se for um Array, o tamanho total será igual ao tipo * o número de elementos do array
        ;MsgBox( Members )
        Pos := RegExMatch( Members[ Count + 1 ], "\[(.*?)\]", &Match)
        if ( Pos ) {
            Values := SubStr( Match[1], 1, ( StrLen( Members[ Count + 1 ] ) - Pos ) )
            ;Verifica se o valor é um número ou se é uma constante
            if ( !IsNumber( Values ) ) {
            ;Verifica se a constante esta na lista conhecida
                Values := IniRead( A_ScriptDir "\constants.ini", "CONSTANT", Members[ Count + 1 ] )
                if ( !Values ) {
                    throw( "Erro: Constante não Localizada, Atualize a lista")
                }
            }
            this.sizeT := sizeMember * Values
            this.AkhType.Push( WindowsDataTypes( Members[ Count ], 1 ) )
            this.Members.Push( SubStr( Members[ Count + 1 ], 1, ( Pos - 1 ) ) )

            return 1

        }
        return 0
    }

    LocateStructs( Members ) {

    }
}

Class ParallelStructAhk extends StructAhk {

}

/*
    ;this.Offset - Array
    ;this.OffsetFromMembers - Map
    ;this.Members - Array
    ;this.Type - Array
    ;this.Size - Var
    ;this.Ptr - Var
    ;this.Member1 - Conforme tipo de membro
    ;this.Member2
    ;...
    ;this.MemberN
    __Init() {
        this.Offset := [ 0 ]
        this.OffsetFromMembers := Map()
        super.__New( 0, 0 )
        this.Members := [ ]
        this.Type := [ ]
    }
    __New( Members, Values, IndexSize := "", Name := "" ) {

        Members := StrSplit( Trim( RegExReplace( Members, "(;\s*|\s+)", " " ) ), A_Space )
        iV := 1
        this.OffsetFromMembers.Set( Members[ 2 ], this.Offset[ 1 ] )

        Loop Members.Length {

            if ( Mod( A_Index, 2 ) = 1 ) {

                if ( A_Index > 1 ) {
                    this.Offset.Push( this.Size )
                    this.OffsetFromMembers.Set( Members[ A_Index + 1 ], this.Offset[ this.OffsetFromMembers.Count + 1 ] )
                }
                this.Size += WindowsDataTypes( Members[ A_Index ] )
            }
            else {

                AhkType := WindowsDataTypes( Members[ A_Index - 1 ], 1 )
                this.Type.Push( AhkType )
                this.Members.Push( Members[ A_Index ] )
                if ( !IsObject( Values ) ) {
                    this.%Members[ A_Index ]% := 0
                }
                else {
                    this.%Members[ A_Index ]% := Values[ iV ]
                    NumPut( AhkType,
                            Values[ iV ],
                            this.Ptr,
                            this.Offset[ iV ] )
                    ++iV
                }
            }
        }
        if ( IsNumber( IndexSize ) ) {

            this.%this.Members[ IndexSize ]% := this.Size
            NumPut( this.Type[ IndexSize ],
                    this.Size,
                    this.Ptr,
                    this.Offset[ IndexSize ] )
        }
    }
    SetValues( Member, _Values ) {
        this.%Member% := _Values
        i := 1
        while ( this.Offset[ i ] != this.OffsetFromMembers[ Member ]) {
            ++i
        }
        NumPut( this.Type[ i ],
                _Values,
                this.Ptr,
                this.OffsetFromMembers[ Member ] )
    }
                /*
                this.Offset.Set( WindowsDataTypes( j, 1, 1 ), WindowsDataTypes( j ) )

                if ( i = 1 ) {
                    this.Offset.Set( WindowsDataTypes( j, 1, Init ), WindowsDataTypes( j ) )
                    --Init
                }
                this.Offset.Set( WindowsDataTypes( j, 1 ), WindowsDataTypes( j ) )



                if ( ( A_Index > 1 ) && ( A_Index < Members.Length ) ) {
                    this.Offset.Set( WindowsDataTypes( j, 1 ), WindowsDataTypes( j ) )
                    if ( A_Index = Members.Length - 1 ) {
                        this.Size := this.Offset + WindowsDataTypes( j )
                    }
                }
            }

            msg
            else {
                if( IsObject( Values ) ) {
                    ;NumPut()
                }
            }
            */

        ;MsgBox( Size )
        ;MsgBox( this.Size )


        ;loop parse Members, A_Space {
        ;;    MsgBox( A_LoopField )
        ;    if ( A_LoopField != "" ) {
        ;        ToolTip( A_LoopField )
        ;    }
        ;}

        ;Members := RegExReplace( Members, "(;\s*|\s+)", " " )
        ;MsgBox( Members )


;}
;MsgBox( ( A_TickCount - on ) / 1000  )

/*  Criar tipos ahk compatível com as estrutura solicitadas como parâmetros
 * quando do uso de DllCall()
 *  Members
 *      Podem ser obtidos diretamente da sintaxe de uma das APIs do Windows, por exemplo;
 *
 *      Sintaxe RECT C++
 *      typedef struct tagRECT {
 *          LONG left;
 *          LONG top;
 *          LONG right;
 *          LONG bottom;
 *       } RECT, *PRECT, *NPRECT, *LPRECT;
 *
 *      A partir desta sintaxe pode obter o parâmetro para criação de uma StructAhk, copiando a parte
 *      entre chaves:
 *      Members :=
 *          (
 *          "LONG left;
 *          LONG top;
 *          LONG right;
 *          LONG bottom;"
 *          )
 *
 *  Values
 *      Se o desejo é cria uma estrutura com os tipos atribuidos, forneça uma string com o valores
 *      de cada membro da estrutura. Por Exemplo:
 *          Values := "left 0, top 0, right, bottom, 0" ou;
 *          Valoes := "0, 0, 0, 0"
 *      É comum, como ums dos membros de 'Struct' ser o valor total, ver adiante.
 *      Também é comum ema Struct, ter como um de seus membros uma outra Struct, que deverá ser antes
 *      atribuída
 *
 *   SizeMember
 *      Algumas Structs exige que um de seus membro reflita seu tamanho total, 'SizeMember' é o membro
 *      que receberár o tamanho total. Caso não seja necessário de como uma string vazia.
*/







/*



#Include WindowsDataTypes.ahk
#Include ParamFromStr.ahk

on := A_TickCount
;Usage
;Ass := StructAhk.Call( )

Members :=
    (
    "LONG left;
    LONG top;
    LONG right;
    LONG bottom;"
    )

Ass := StructAhk( Members, 0, 1 )

MsgBox( Ass.OffsetFromMembers["bottom"] )
Ass.SetValues( "left", 30 )
MsgBox( NumGet( Ass.Ptr, Ass.OffsetFromMembers[ "left" ], Ass.Type ) )
Esc::ExitApp()
class StructAhk extends Buffer {
    ;this.Offset - Array
    ;this.OffsetFromMembers - Map
    ;this.Members - Array
    ;this.Type - Array
    ;this.Size - Var
    ;this.Ptr - Var
    ;this.Member1 - Conforme tipo de membro
    ;this.Member2
    ;...
    ;this.MemberN
    __Init() {
        this.Offset := [ 0 ]
        this.OffsetFromMembers := Map()
        this.MembersFromOffset := Map()
        this.AhkTypeFromOffset := Map()
        this.ValuesFromOffset  := Map()
        this.SizeFromOffset := Map()
        this.Size := 0
        super.__New( this.Size, 0 )
    }
    __New( Members, Values, IndexSize := "", Name := "" ) {

        Members := StrSplit( Trim( RegExReplace( Members, "(;\s*|\s+)", " " ) ), A_Space )
        iV := 1

        AhkTypes := WindowsDataTypes( Members[ 1 ], 1 )
        this.Size := WindowsDataTypes( Members[ 1 ] )
        Size := 0

        this.OffsetFromMembers.Set( Members[ 2 ], this.Offset[ 1 ] )
        this.MembersFromOffset.Set( this.Offset[ 1 ], Members[ 2 ] )
        this.SizeFromOffset.Set( this.Offset[ 1 ], Members[ 2 ] )
        this.AhkTypeFromOffset.Set( this.Offset[ 1 ], AhkTypes )
        this.SizeFromOffset.Set( this.Offset[ 1 ], this.Size )

        if ( IsObject( Values ) ) {
            this.ValuesFromOffset.Set( Values[ 1 ] )
        }
        else {
            this.ValuesFromOffset.Set( this.Offset[ 1 ], 0 )
        }

        Loop Members.Length {

            if ( Mod( A_Index, 2 ) = 1 ) {

                if ( A_Index > 1 ) { ; Index - 3, 5, 7
                    this.Size += WindowsDataTypes( Members[ A_Index ] )

                    this.Offset.Push( this.Offset[ A_Index - 2  ] this.Size )

                    this.SizeFromOffset.Set( this.Offset[ A_Index - 1 ],
                                             WindowsDataTypes( Members[ A_Index + 1 ] ) )

                    this.OffsetFromMembers.Set( Members[ A_Index ],
                                                this.Offset[ A_Index - 1 ] )

                    this.MembersFromOffset.Set( this.Offset[ A_Index ],
                                                Members[ A_Index + 1 ] )

                    this.AhkTypeFromOffset.Set( this.Offset[ A_Index ],
                                                WindowsDataTypes( Members[ A_Index ], 1 ) )

                    MsgBox( Members[ A_Index + 1 ] )

                    ;for i, j in this.Offset
                    ;    MsgBox( i "-" j)

                    ;Size := WindowsDataTypes( Members[ A_Index ] )
                    ;MsgBox( Size )
                    ;this.Offset.Push( Size )
                    ;MsgBox Members[ A_Index + 1 ]
                    this.OffsetFromMembers.Set( Members[ A_Index + 1 ],
                                                this.Offset[ this.OffsetFromMembers.Count + 1 ] )
                }
                ;this.Size += WindowsDataTypes( Members[ A_Index ] )
            }
        }
        /*
            else {

                AhkType := WindowsDataTypes( Members[ A_Index - 1 ], 1 )
                this.Type.Push( AhkType )

                this.Members.Push( Members[ A_Index ] )
                if ( !IsObject( Values ) ) {
                    this.%Members[ A_Index ]% := 0
                }
                else {
                    this.%Members[ A_Index ]% := Values[ iV ]
                    NumPut( AhkType,
                            Values[ iV ],
                            this.Ptr,
                            this.Offset[ iV ] )
                    ++iV
                }
            }
        }
        if ( IsNumber( IndexSize ) ) {

            this.%this.Members[ IndexSize ]% := this.Size
            NumPut( this.Type[ IndexSize ],
                    this.Size,
                    this.Ptr,
                    this.Offset[ IndexSize ] )
        }
    }
    SetValues( Member, _Values ) {
        this.%Member% := _Values
        i := 1
        while ( this.Offset[ i ] != this.OffsetFromMembers[ Member ]) {
            ++i
        }
        NumPut( this.Type[ i ],
                _Values,
                this.Ptr,
                this.OffsetFromMembers[ Member ] )
    }
                /*
                this.Offset.Set( WindowsDataTypes( j, 1, 1 ), WindowsDataTypes( j ) )

                if ( i = 1 ) {
                    this.Offset.Set( WindowsDataTypes( j, 1, Init ), WindowsDataTypes( j ) )
                    --Init
                }
                this.Offset.Set( WindowsDataTypes( j, 1 ), WindowsDataTypes( j ) )



                if ( ( A_Index > 1 ) && ( A_Index < Members.Length ) ) {
                    this.Offset.Set( WindowsDataTypes( j, 1 ), WindowsDataTypes( j ) )
                    if ( A_Index = Members.Length - 1 ) {
                        this.Size := this.Offset + WindowsDataTypes( j )
                    }
                }
            }

            msg
            else {
                if( IsObject( Values ) ) {
                    ;NumPut()
                }
            }
            */

        ;MsgBox( Size )
        ;MsgBox( this.Size )


        ;loop parse Members, A_Space {
        ;;    MsgBox( A_LoopField )
        ;    if ( A_LoopField != "" ) {
        ;        ToolTip( A_LoopField )
        ;    }
        ;}

        ;Members := RegExReplace( Members, "(;\s*|\s+)", " " )
        ;MsgBox( Members )


  ;  }
;}
;MsgBox( ( A_TickCount - on ) / 1000  )
/*  Criar tipos ahk compatível com as estrutura solicitadas como parâmetros
 * quando do uso de DllCall()
 *  Members
 *      Podem ser obtidos diretamente da sintaxe de uma das APIs do Windows, por exemplo;
 *
 *      Sintaxe RECT C++
 *      typedef struct tagRECT {
 *          LONG left;
 *          LONG top;
 *          LONG right;
 *          LONG bottom;
 *       } RECT, *PRECT, *NPRECT, *LPRECT;
 *
 *      A partir desta sintaxe pode obter o parâmetro para criação de uma StructAhk, copiando a parte
 *      entre chaves:
 *      Members :=
 *          (
 *          "LONG left;
 *          LONG top;
 *          LONG right;
 *          LONG bottom;"
 *          )
 *
 *  Values
 *      Se o desejo é cria uma estrutura com os tipos atribuidos, forneça uma string com o valores
 *      de cada membro da estrutura. Por Exemplo:
 *          Values := "left 0, top 0, right, bottom, 0" ou;
 *          Valoes := "0, 0, 0, 0"
 *      É comum, como ums dos membros de 'Struct' ser o valor total, ver adiante.
 *      Também é comum ema Struct, ter como um de seus membros uma outra Struct, que deverá ser antes
 *      atribuída
 *
 *   SizeMember
 *      Algumas Structs exige que um de seus membro reflita seu tamanho total, 'SizeMember' é o membro
 *      que receberár o tamanho total. Caso não seja necessário de como uma string vazia.
*/