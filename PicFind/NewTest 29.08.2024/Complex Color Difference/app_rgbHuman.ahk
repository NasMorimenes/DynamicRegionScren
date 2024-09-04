;#Include Includes.ahk
R := 255
G := 25
B := 100

X := Buffer(12, 0)

result :=
    DllCall(
        "rgbHuman.dll\color_difference",
        "uint", R,
        "uint", G,
        "uint", B,
        "Ptr", X.Ptr
    )

MsgBox "X: " NumGet(x, 0, "float") ", Y: " NumGet(x, 4, "float") ", Z: " NumGet(x, 8, "float")