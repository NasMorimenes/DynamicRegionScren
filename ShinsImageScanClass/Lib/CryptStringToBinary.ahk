CryptStringToBinary( hex, &code, len ) {
    DllCall(
        "crypt32\CryptStringToBinary",
        "Str"   , hex,
        "UInt"  , 0,
        "UInt"  , 4,
        "Ptr"   , code,
        "UInt*" , &len,
        "Ptr"   , 0,
        "Ptr"   , 0
    )
}
/*

https://learn.microsoft.com/en-us/windows/win32/api/wincrypt/nf-wincrypt-cryptstringtobinarya
Função CryptStringToBinaryA (wincrypt.h)

A função CryptStringToBinary converte uma string formatada em uma matriz de bytes.

Sintaxe
```cpp
BOOL CryptStringToBinaryA(
  [in]      LPCSTR pszString,
  [in]      DWORD  cchString,
  [in]      DWORD  dwFlags,
  [in]      BYTE   *pbBinary,
  [in, out] DWORD  *pcbBinary,
  [out]     DWORD  *pdwSkip,
  [out]     DWORD  *pdwFlags
);
```

Parâmetros
- **pszString** [entrada]: Um ponteiro para uma string que contém a string formatada a ser convertida.
- **cchString** [entrada]: O número de caracteres da string formatada a ser convertida, excluindo o caractere nulo terminador. Se este parâmetro for zero, pszString será considerado uma string terminada por nulo.

Value	                        |               Meaning
----------------------------------------------------------------------------------------------
CRYPT_STRING_BASE64HEADER       |	Base64 between lines of the form `-----BEGIN ...
0x00000000                      |    -----` and `-----END ...-----`. See Remarks below.
----------------------------------------------------------------------------------------------	
CRYPT_STRING_BASE64             |   Base64, without headers.
0x00000001                      |
----------------------------------------------------------------------------------------------	
CRYPT_STRING_BINARY	            |   Pure binary copy.
0x00000002                      |
----------------------------------------------------------------------------------------------	
CRYPT_STRING_BASE64REQUESTHEADER|	Base64 between lines of the form `-----BEGIN ...
                                |   -----` and `-----END ...-----`. See Remarks below.
0x00000003	
----------------------------------------------------------------------------------------------	
CRYPT_STRING_HEX                |   Hexadecimal only format.
0x00000004                      |	
----------------------------------------------------------------------------------------------	
CRYPT_STRING_HEXASCII           |   Hexadecimal format with ASCII character display.
0x00000005                      |
----------------------------------------------------------------------------------------------		
CRYPT_STRING_BASE64_ANY         |   Tries the following, in order:
0x00000006                      |   CRYPT_STRING_BASE64HEADER
.	                            |   CRYPT_STRING_BASE64
----------------------------------------------------------------------------------------------	
CRYPT_STRING_ANY                |	Tries the following, in order:
0x00000007                      |   CRYPT_STRING_BASE64HEADER
.	                            |   CRYPT_STRING_BASE64
.	                            |   CRYPT_STRING_BINARY
----------------------------------------------------------------------------------------------	
CRYPT_STRING_HEX_ANY	        |   Tries the following, in order:
0x00000008	                    |    CRYPT_STRING_HEXADDR
.                               |    CRYPT_STRING_HEXASCIIADDR
.                               |    CRYPT_STRING_HEX
.                               |    CRYPT_STRING_HEXRAW
.                               |    CRYPT_STRING_HEXASCII
----------------------------------------------------------------------------------------------	
CRYPT_STRING_BASE64X509CRLHEADER|	Base64 between lines of the form `-----BEGIN ...
0x00000009                      |   -----` and `-----END ...-----`. See Remarks below.
----------------------------------------------------------------------------------------------
CRYPT_STRING_HEXADDR            |   Hex, with address display.
0x0000000a                      |	
----------------------------------------------------------------------------------------------
CRYPT_STRING_HEXASCIIADDR       |   Hex, with ASCII character and address display.
0x0000000b                      |
----------------------------------------------------------------------------------------------	
CRYPT_STRING_HEXRAW             |   A raw hexadecimal string. Windows Server 2003 and
0x0000000c	                    |    Windows XP: This value is not supported.
----------------------------------------------------------------------------------------------	
CRYPT_STRING_STRICT             |	Set this flag for Base64 data to specify that the
0x20000000                      |   end of the binary data contain only white space and 
.                               |   at most three equals "=" signs.
.        	                    |   Windows Server 2008, Windows Vista, Windows Server
.                               |   2003 and Windows XP:  This value is not supported.

Set this flag for Base64 data to specify that the end of the binary data contain only white space and at most three equals "=" signs.
Windows Server 2008, Windows Vista, Windows Server 2003 and Windows XP:  This value is not supported.
- **dwFlags** [entrada]: Indica o formato da string a ser convertida. Isso pode ser um dos seguintes valores.
- **pbBinary** [entrada]: Um ponteiro para um buffer que recebe a sequência de bytes retornada. Se este parâmetro for NULL, a função calcula o comprimento do buffer necessário e retorna o tamanho, em bytes, da memória necessária no DWORD apontado por pcbBinary.
- **pcbBinary** [entrada, saída]: Um ponteiro para uma variável DWORD que, na entrada, contém o tamanho, em bytes, do buffer pbBinary. Após o retorno da função, essa variável contém o número de bytes copiados para o buffer. Se este valor não for grande o suficiente para conter todos os dados, a função falhará e GetLastError retornará ERROR_MORE_DATA.
- **pdwSkip** [saída]: Um ponteiro para um valor DWORD que recebe o número de caracteres ignorados para alcançar o início do cabeçalho -----BEGIN ...-----. Se nenhum cabeçalho estiver presente, o DWORD será definido como zero. Este parâmetro é opcional e pode ser NULL se não for necessário.
- **pdwFlags** [saída]: Um ponteiro para um valor DWORD que recebe as flags realmente usadas na conversão. Estas são as mesmas flags usadas para o parâmetro dwFlags. Na maioria dos casos, essas serão as mesmas flags que foram passadas no parâmetro dwFlags. Se dwFlags contiver uma das seguintes flags, este valor receberá uma flag que indica o formato real da string. Este parâmetro é opcional e pode ser NULL se não for necessário.

Valor de Retorno
- Se a função for bem-sucedida, o valor de retorno é diferente de zero (TRUE).
- Se a função falhar, o valor de retorno é zero (FALSE).

Observações
- As flags CRYPT_STRING_BASE64HEADER, CRYPT_STRING_BASE64REQUESTHEADER e CRYPT_STRING_BASE64X509CRLHEADER são tratadas de forma idêntica por esta função: Elas tentam analisar o primeiro bloco de dados codificados em base64 entre linhas do formato -----BEGIN ...----- e -----END ...-----. As porções ... são ignoradas, e elas não precisam corresponder. Se o parsing for bem-sucedido, o valor passado no parâmetro dwFlags é retornado no DWORD apontado pelo parâmetro pdwFlags. Note que um valor de CRYPT_STRING_BASE64REQUESTHEADER ou CRYPT_STRING_BASE64X509CRLHEADER não significa que um cabeçalho de solicitação ou uma lista de revogação de certificado X.509 (CRL) foi encontrado.