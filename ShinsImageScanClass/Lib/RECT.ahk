RECT( sX, sY, iX, iY) {
    _rect := Buffer( 16, 0 )
    NumPut( "UInt", sX,
            "Uint", sY,
            "UInt", iX,
            "UInt", iY,
            _rect )  ;, 4 * ( A_Index - 1 ) )
  return _rect
    
}
/* Class StructCPP
Members :=
(
  "LONG left;
  LONG top;
  LONG right;
  LONG bottom;"
)
RECT := StructCpp( "Rect", Menbers, Value )

/*

A estrutura RECT (windef.h) define um retângulo pelos coordenadas de seus cantos superior esquerdo e inferior direito.

Sintaxe
C++

```cpp
typedef struct tagRECT {
  LONG left;
  LONG top;
  LONG right;
  LONG bottom;
} RECT, *PRECT, *NPRECT, *LPRECT;
```

Membros
left

Especifica a coordenada x do canto superior esquerdo do retângulo.

top

Especifica a coordenada y do canto superior esquerdo do retângulo.

right

Especifica a coordenada x do canto inferior direito do retângulo.

bottom

Especifica a coordenada y do canto inferior direito do retângulo.