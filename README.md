#### IDENTIFICACAO ####
Luiz Guilherme Silva Moreira RA:202391
Ian Goulart Doretto RA: 174827
#### ARQUIVO DE INSTRUCOES ####

- No diretório ".../Trabalho1/" digite o comando make para compilar todos os arquivos;
- Após o processo você pode testar o programa através do seguinte comando ainda no mesmo diretório:
echo "expressao_desejada" | ./main
- Caso tudo seja feito corretamente, para finalização do trabalho basta copiar a saída gerada pelo programa, visitar o simulador linkado abaixo e verificar a resposta da expressão que será armazenada no registrador de propósito geral A:
https://schweigi.github.io/assembler-simulator/
- Para a simulação no site, basta limpar o conteudo do simulador pré-colocado, colar a saída gerada pelo programa e clicar em "Run".
- Vale lembrar que para repetir o processo deve se clicar em "Reset" e repetir o procedimento.

#### INSTRUCOES VALIDAS E CONSIDERACOES ####
- A calculadora é capaz de realizar:
* Soma: echo "NUMERO1 + NUMERO2" | ./main
* Subtracao: echo "NUMERO1 - NUMERO2" | ./main
* Multiplicacao: echo "NUMERO1 * NUMERO2" | ./main
* Exponenciacao: echo "NUMERO1 ^ NUMERO2" | ./main
- A calculadora também suporta o uso de parenteses () nas expressões;
- Os números devem ser inteiros e positivos;
- Qualquer outro formato de instrução que não seja o citado não funcionará e acarretará erro de sintaxe.
