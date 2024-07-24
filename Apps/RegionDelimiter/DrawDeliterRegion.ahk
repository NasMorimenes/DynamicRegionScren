#Include C:\Users\morim\OneDrive\DynamicRegionScren\Draw\ClassRectangle\class PosicaoX.ahk
#Include C:\Users\morim\OneDrive\DynamicRegionScren\Draw\ClassRectangle\class PosicaoY.ahk
#Include C:\Users\morim\OneDrive\DynamicRegionScren\Draw\ClassRectangle\class Ponto.ahk


DrawDelimiterRegion()

DrawDelimiterRegion( params* ) {
    CreateLimit := CreationInterface()
}

CreationInterface() {
    pIni := 0
    PFim := 0
    SelectPointIni()
    SelectPointFim()
    return 0
}

SelectPointIni( &pIni := 0 ) {
    posiX := PosicaoX()
    posiY := PosicaoY()
    pIni := Ponto( posiX, posiY )
    
}

SelectPointFim( &pFim := 0 ) {
    posiX := PosicaoX()
    posiY := PosicaoY()
    pFim := Ponto( posiX, posiY )
}