#Include C:\Users\morim\OneDrive\DynamicRegionScren\Draw\ClassRectangle\class PosicaoX.ahk
#Include C:\Users\morim\OneDrive\DynamicRegionScren\Draw\ClassRectangle\class PosicaoY.ahk
#Include C:\Users\morim\OneDrive\DynamicRegionScren\Draw\ClassRectangle\class Ponto.ahk
#Include C:\Users\morim\OneDrive\DynamicRegionScren\HooK\MsgMonitor\AppsFromHooks\CaptorScreen\MouseDownUp.v2.ahk


posiXi := PosicaoX()
posiYi := PosicaoY()

posiXf := PosicaoX()
posiYf := PosicaoY()

pIni := Ponto( posiXi, posiYi )
PFim := Ponto( posiXf, posiYf )

DrawDelimiterRegion( pIni, PFim )

DrawDelimiterRegion( params* ) {
    CreateLimit := CreationInterface()
}

CreationInterface() {
    SelectPointIni()
    SelectPointFim()
    return 0
}

SelectPointIni( &pIni := 0 ) {
    posiXi := 
    posiYi := 
    ;pIni := Ponto( posiX, posiY )
    
}

SelectPointFim( &pFim := 0 ) {
    posiXi := 
    posiYi := 
    ;pFim := Ponto( posiX, posiY )
}