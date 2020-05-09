%{
#include <stdlib.h>
void yyerror(char *c);
#include "y.tab.h"
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

[-] {
     return SUBTRACAO;
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
