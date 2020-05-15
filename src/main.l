%{
#include <stdlib.h>
#include "y.tab.h"
void yyerror(char *c);
/* Variavel auxiliadora */
int val_erro = 0;
%}

%%
[0-9]+ {
	yylval = atoi(yytext);
	return INTEIRO;
}

[\n] {
	return FIMDELINHA;
}

[+] {
	return SOMA;
}

[/] {
     return DIVISAO;
}

[*] {
    return MULTIPLICACAO;
}

[(] {
    return ABREPARENTESE;
}

[)] {
    return FECHAPARENTESE;
}

[\^] {
     return EXPONENCIACAO;
}

[ \t]+ ; 

[[:space:]]+ ;

. 
%%

int yywrap(){
	return 1;
}
