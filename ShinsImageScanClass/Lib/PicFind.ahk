/*
int __attribute__((__stdcall__)) PicFind(

	int mode,
	unsigned int c,
	unsigned int n,
	int offsetX,
	int offsetY,
	unsigned char * Bmp,
	int Stride,
	int sx,
	int sy,
	int sw,
	int sh,
	unsigned char * gs,
	char * ss,
	char * text,
	int * s1,
	int * s0,
	int * input,
	int num,
	unsigned int * allpos,
	int allpos_max
)
{

int o, i, j, x, y, r, g, b, rr, gg, bb, max, e1, e0, ok;
  int o1, x1, y1, w1, h1, sx1, sy1, len1, len0, err1, err0;
  int o2, x2, y2, w2, h2, sx2, sy2, len21, len20, err21, err20;
  int r_min, r_max, g_min, g_max, b_min, b_max;
*/

/*
Parâmetros da Função:
mode: Modo de operação da função. Pode determinar como a imagem é processada, com base em diferentes critérios de correspondência de cor ou intensidade de pixels.
c e n: Parâmetros de cor, usados para definir os critérios de correspondência. Dependendo do modo, esses valores podem representar uma cor específica ou limiares para comparação.
offsetX, offsetY: Offsets usados no cálculo das coordenadas dentro da imagem.
Bmp: Ponteiro para os dados da imagem na qual a busca será realizada.
Stride: Quantidade de bytes que representa a largura de uma linha da imagem na memória, utilizada para navegar na imagem.
sx, sy, sw, sh: Posição (x, y) e dimensões (largura, altura) da subárea da imagem onde a busca será realizada.
gs, ss, text: Buffers utilizados para armazenar informações intermediárias durante o processo de busca. gs armazena valores de escala de cinza, ss armazena os resultados binários da comparação, e text armazena o padrão de pesquisa.
s1, s0: Arrays que armazenam os índices dos pixels que precisam ou não precisam corresponder ao padrão.
input: Array de entrada que contém diversos parâmetros de configuração, como dimensões de subimagens e limites de erro.
num: Número de elementos no array input.
allpos: Array para armazenar as posições (coordenadas) onde as correspondências são encontradas.
allpos_max: Número máximo de correspondências a serem armazenadas.
*/

Str := "zzzzzzzzzzzzzzzzzw3zy0Dz03zk4Ts27y70zUUDs07z01zk0zy0TzsDzzzzzzzzzzy"
text := StrSplit( Str )

PicFind( 0,0,0,0,0,0,0,0,0,00,0,text, 0 )

PicFind(
	mode, ;Diferentes critérios de correspondência de cor ou intensidade de pixels.
	c, n, ; Dependendo do modo, esses valores podem representar uma cor específica ou limiares para comparação.
	offsetX, offsetY, ;Offsets usados no cálculo das coordenadas dentro da imagem.	
	Stride, ;Quantidade de bytes que representa a largura de uma linha da imagem na memória, utilizada para navegar na imagem.
	sx,	sy,	sw,	sh, ;Posição (x, y) e dimensões (largura, altura) da subárea da imagem onde a busca será realizada.
	num, ;Número de elementos no array input.
	text, ;Buffer( 0, 0 ), ; text armazena o padrão de pesquisa.
	allpos_max, ;Número máximo de correspondências a serem armazenadas.
	allpos := Buffer( 0, 0 ), ;Array para armazenar as posições (coordenadas) onde as correspondências são encontradas.
    bmp := Buffer( 0, 0 ), ;Ponteiro para os dados da imagem na qual a busca será realizada.
	gs := Buffer( 0, 0 ), ; gs armazena valores de escala de cinza
	ss := Buffer( 0, 0 ), ; ss armazena os resultados binários da comparação
	s1 := s0 := Buffer( 0, 0 ), ; Arrays que armazenam os índices dos pixels que precisam ou não precisam corresponder ao padrão.
	input := [ 0, 0, 0, 0, 0, 0, 0 ] ;Contém diversos parâmetros de configuração, como dimensões de subimagens e limites de erro.
    ) { 
	
    static i
	ok := 0 ;ok=0
	
	w1 := input[ 2 ] ;NumGet( input, 4, "Int" ) ;w1=input[1];
	h1 := input[ 3 ] ;NumGet( input, 8, "Int" ) ;h1=input[2]
	
	len1 := input[ 4 ] ;NumGet( input, 12, "Int" ) ;len1=input[3];
	len0 := input[ 5 ] ;NumGet( input, 16, "Int" ) ;len0=input[4];
	
	err1 := input[ 6 ] ;NumGet( input, 20, "Int") ;err1=input[5];
	err0 := input[ 7 ] ;NumGet( input, 24, "Int") ;err0=input[6];
	
	max := ( len1 > len0 ) ? len1 : len0 ;max=len1>len0 ? len1 : len0;
	
	j := 0,	y := 0,	x := 0
	
	while ( j < num ) { ;&& y := y + 1 )
        o := input[ j ]
        o1 := input[ j ]
        o2 := input[ j ]
        w2 := input[ j + 1] 
        h2 := input[ j + 2 ]

        while ( y < h2 ) {

            while ( x < w2 ) {

                i := ( mode == 3 ) ? ( y * Stride + x * 4 ) : ( y * sw + x )

                if ( text[ o++ ] == '1' ) 
                    s1[ o1++ ] := i
                else
                    s0[ o2++ ] := i

                ++x
            }
            ++y
        }
        ++j
    }
}


MsgBox GetStride( 8, 32 )

GetStride( biWidth, biBitCount ) {
	return ((biWidth * biBitCount + 31) & ~31) >> 3
}





/*









// Start Lookup
  
  sx1 = sw - w1
  sy1 = sh - h1
  
  for ( y=0; y <= sy1; y++)
  {
    for (x=0; x<=sx1; x++)
    {
      o=y*sw+x; e1=err1; e0=err0;
      if (e0==len0)
      {
        for (i=0; i<len1; i++)
          if (ss[o+s1[i]]!=1 && (--e1)<0)
            goto NoMatch1;
      }
      else
      {
        for (i=0; i<max; i++)
        {
          if (i<len1 && ss[o+s1[i]]!=1 && (--e1)<0)
            goto NoMatch1;
          if (i<len0 && ss[o+s0[i]]!=0 && (--e0)<0)
            goto NoMatch1;
        }
      }
      //------------------
      // Combination lookup
      if (num>7)
      {
        x1=x+w1-1; y1=y-offsetY; if (y1<0) y1=0;
        for (j=7; j<num; j+=7)
        {
          o2=input[j]; w2=input[j+1]; h2=input[j+2];
          len21=input[j+3]; len20=input[j+4];
          err21=input[j+5]; err20=input[j+6];
          sx2=sw-w2; i=x1+offsetX; if (i<sx2) sx2=i;
          sy2=sh-h2; i=y+offsetY; if (i<sy2) sy2=i;
          for (x2=x1; x2<=sx2; x2++)
          {
            for (y2=y1; y2<=sy2; y2++)
            {
              o1=y2*sw+x2; e1=err21; e0=err20;
              for (i=0; i<len21; i++)
              {
                if (ss[o1+s1[o2+i]]!=1 && (--e1)<0)
                  goto NoMatch2;
              }
              if (e0!=len20)
              {
                for (i=0; i<len20; i++)
                  if (ss[o1+s0[o2+i]]!=0 && (--e0)<0)
                    goto NoMatch2;
              }
              goto MatchOK;
              NoMatch2:
              continue;
            }
          }
          goto NoMatch1;
          MatchOK:
          x1=x2+w2-1;
        }
      }
      //------------------
      allpos[ok++]=(sy+y)<<16|(sx+x);
      if (ok>=allpos_max)
        goto Return1;
      // Clear the image that has been found
      for (i=0; i<len1; i++)
        ss[o+s1[i]]=0;
      NoMatch1:
      continue;
    }
  }