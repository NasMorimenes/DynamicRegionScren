/*
Referências:
- https://www.cnblogs.com/wxl845235800/p/11079403.html
- https://blog.csdn.net/lz0499/article/details/77345166
- https://www.jianshu.com/p/86e8c3acd41d

AutoHotkey v2.0-beta 2

Essa função utiliza o modelo de cor LAB junto com o algoritmo CIEDE2000 para calcular
a diferença de cor entre dois valores. Quanto maior o valor retornado, menor a similaridade entre as cores.
*/
#Include Lib\*.ahk
white := 0xffffff
black := 0x000000
gray := 0x808080
deltaE := ColorDiff(white, black)
MsgBox("A diferença de cor entre branco e preto é: " deltaE)
deltaE := ColorDiff(white, gray)
MsgBox("A diferença de cor entre branco e cinza é: " deltaE)