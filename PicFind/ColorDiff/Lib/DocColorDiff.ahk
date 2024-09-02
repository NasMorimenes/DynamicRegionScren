/*
Esse script AutoHotkey implementa uma função chamada `ColorDiff` que calcula a diferença de cor entre dois valores de cor em formato hexadecimal (representando cores em sRGB). O cálculo da diferença de cor é feito usando o modelo de cores LAB e a fórmula CIEDE2000, que é uma métrica avançada para medir a diferença perceptual entre duas cores. Aqui está uma explicação detalhada de como o script funciona:

### Função Principal: `ColorDiff(hex1, hex2)`

1. **Conversão de Hexadecimal para RGB:**
   - As cores de entrada `hex1` e `hex2` são convertidas de valores hexadecimais para seus componentes RGB (Red, Green, Blue) usando a função `Hex2RGB`.

2. **Conversão de RGB para XYZ:**
   - Os valores RGB são então convertidos para o espaço de cores CIE XYZ utilizando a função `RGB2XYZ`.

3. **Conversão de XYZ para LAB:**
   - Em seguida, os valores XYZ são convertidos para o espaço de cores LAB usando a função `XYZ2Lab`.

4. **Cálculo da Diferença de Cor:**
   - Finalmente, a diferença entre as duas cores no espaço LAB é calculada usando a fórmula CIEDE2000, implementada na função `GetDeltaEByLab`.

5. **Retorno:**
   - A função retorna o valor da diferença de cor, onde um valor maior indica uma maior diferença perceptual entre as duas cores.

### Funções Auxiliares:

#### 1. `Hex2RGB(hex)`
   - Converte um valor hexadecimal de cor em seus componentes RGB (vermelho, verde, azul).

#### 2. `RGB2Hex(r, g, b)`
   - Converte valores RGB de volta para o formato hexadecimal.

#### 3. `RGB2XYZ(R, G, B)`
   - Converte os valores RGB para o espaço de cores XYZ.
   - Aplica uma correção gamma aos valores RGB e multiplica-os por uma matriz de transformação para obter os valores XYZ.

#### 4. `Gamma(x)`
   - Aplica a correção gamma necessária para converter os valores sRGB para um formato linear antes da conversão para XYZ.

#### 5. `XYZ2Lab(X, Y, Z)`
   - Converte os valores XYZ para o espaço de cores LAB.
   - Inclui a normalização em relação ao ponto branco de referência D65 e aplica a função LAB.

#### 6. `GetDeltaEByLab(L1, a1, b1, L2, a2, b2)`
   - Implementa a fórmula CIEDE2000 para calcular a diferença de cor entre duas cores no espaço LAB.
   - A fórmula CIEDE2000 é mais avançada que suas predecessoras (como ΔE76 e ΔE94), levando em consideração a percepção humana mais acurada das cores.

#### 7. `GetChroma(a, b)`
   - Calcula a cromaticidade (intensidade da cor) a partir dos valores `a` e `b` no espaço LAB.

#### 8. `GetHueAngle(a, b)`
   - Calcula o ângulo de matiz (hue angle) para os valores `a` e `b` no espaço LAB.
   - O ângulo de matiz é uma representação circular da cor, útil para determinar a "direção" da cor em relação a uma base de referência.

### Explicação Detalhada de Algumas Funções Chave:

- **CIEDE2000** (`GetDeltaEByLab`):
  - Essa função calcula a diferença entre duas cores no espaço LAB levando em consideração três componentes: diferença de luminosidade (`L*`), diferença de cromaticidade (`C*`), e diferença de matiz (`H*`).
  - Ela também inclui ajustes adicionais como `RT`, que leva em conta a rotação do espaço de cor LAB, ajustando a medida da diferença de cor para melhor refletir a percepção humana.

- **Normalização LAB** (`XYZ2Lab`):
  - Ao converter XYZ para LAB, a função normaliza os valores XYZ com base em um ponto branco de referência (`D65`), que é uma iluminação padrão usada em muitas aplicações de colorimetria.

### Aplicação:

Essa implementação é útil em muitas áreas onde é importante medir a diferença perceptível entre duas cores, como em design gráfico, calibração de monitores, impressão e controle de qualidade em processos de fabricação. A fórmula CIEDE2000 é amplamente reconhecida por sua precisão na modelagem da percepção humana de diferenças de cor, tornando-a uma escolha ideal para essas aplicações.