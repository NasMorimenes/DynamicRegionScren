VirtualProtect( Code, len ) {
    bool :=
    DllCall( 
        "VirtualProtect",
        "Ptr"   , code,
        "Ptr"   , len,
        "UInt"  , 0x40,
        "Ptr*"  , 0,
        "UInt"
    )
    return bool
}

/*
Função VirtualProtect (memoryapi.h)

Altera a proteção em uma região de páginas comprometidas no espaço de endereço virtual do processo que a chama.

Para alterar a proteção de acesso de qualquer processo, use a função VirtualProtectEx.

Sintaxe
```cpp
BOOL VirtualProtect(
  [in]  LPVOID lpAddress,
  [in]  SIZE_T dwSize,
  [in]  DWORD  flNewProtect,
  [out] PDWORD lpflOldProtect
);
```

Parâmetros
- **lpAddress** [entrada]: O endereço da página inicial da região de páginas cujos atributos de proteção de acesso devem ser alterados.
- **dwSize** [entrada]: O tamanho da região cujos atributos de proteção de acesso devem ser alterados, em bytes.
- **flNewProtect** [entrada]: A opção de proteção de memória. Este parâmetro pode ser uma das constantes de proteção de memória.
- **lpflOldProtect** [saída]: Um ponteiro para uma variável que recebe o valor de proteção de acesso anterior da primeira página na região especificada de páginas.

Valor de Retorno
- Se a função for bem-sucedida, o valor de retorno é diferente de zero.
- Se a função falhar, o valor de retorno é zero. Para obter informações de erro estendidas, chame GetLastError.

Observações
- Você só pode definir o valor de proteção de acesso em páginas comprometidas.
- O modificador de proteção PAGE_GUARD estabelece páginas de guarda. Páginas de guarda atuam como alarmes de acesso de única utilização.
- É melhor evitar o uso de VirtualProtect para alterar as proteções de página em blocos de memória alocados por GlobalAlloc, HeapAlloc ou LocalAlloc, porque vários blocos de memória podem existir em uma única página.
- Ao proteger uma região que será executável, o programa chamador é responsável por garantir a coerência da cache por meio de uma chamada apropriada para FlushInstructionCache assim que o código for colocado no lugar.