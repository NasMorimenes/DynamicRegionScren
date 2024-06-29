/*
Arr := {}
CreateLayred( "nova" )
CreateLayred( "Velha" )
for j in ["nova", "Velha" ]
MsgBox( Arr.%j%[ 1 ])

CreateLayred( x ) {
    global Arr
    Arr.%x% := [1]
}
*/

#Include <ClassDraw>
#Include <GdipManager>

gdip := GdipManager()
Ass := Draw( "Pencil", 150, 100, 500, 500,  "FFFF0000", "Teste")
Sleep( 5000 )
Ass1 := Draw( "Eraser", 150, 100, 500, 500,  "00FF0000", "Teste")
Sleep( 5000 )
MsgBox( Ass.Layer.Win )

Esc::ExitApp()