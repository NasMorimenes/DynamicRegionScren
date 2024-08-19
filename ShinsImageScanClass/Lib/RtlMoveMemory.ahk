RtlMoveMemory1( captureWidth , captureHeight, ppvBits ) { 

    sizeScan := captureWidth * captureHeight * 4
    Stride := ( ( captureWidth * 32 + 31 ) // 32) * 4
    Scan := Buffer( sizeScan, 0 )
    DllCall(
        "RtlMoveMemory",
        "Ptr", Scan.Ptr,
        "Ptr", ppvBits,
        "Ptr", Stride * captureHeight
    )
    return Scan
}

/*

A função RtlMoveMemory copia o conteúdo de um bloco de memória de origem para um bloco de memória de destino e suporta blocos de memória de origem e destino que se sobrepõem.

Sintaxe
```cpp
VOID RtlMoveMemory(
  _Out_       VOID UNALIGNED *Destination,
  _In_  const VOID UNALIGNED *Source,
  _In_        SIZE_T         Length
);
```

Parâmetros
- **Destination** [saída]: Um ponteiro para o bloco de memória de destino para copiar os bytes.
- **Source** [entrada]: Um ponteiro para o bloco de memória de origem para copiar os bytes.
- **Length** [entrada]: O número de bytes para copiar da origem para o destino.

Valor de retorno
- Nenhum

Observações
- O bloco de memória de origem, definido por Source e Length, pode se sobrepor ao bloco de memória de destino, definido por Destination e Length.
- A rotina RtlCopyMemory é mais rápida que a RtlMoveMemory, mas a RtlCopyMemory requer que os blocos de memória de origem e destino não se sobreponham.
- Os chamadores de RtlMoveMemory podem estar em qualquer IRQL se os blocos de memória de origem e destino estiverem na memória do sistema não paginada. Caso contrário, o chamador deve estar em IRQL <= APC_LEVEL.