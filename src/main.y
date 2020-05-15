%{
#include <stdio.h>

void yyerror(char *c);
int yylex(void);
/* Variavel auxiliadora */
int i = 0;
%}

/* Declaracao dos tokens da calculadora */
%token INTEIRO SOMA DIVISAO MULTIPLICACAO EXPONENCIACAO ABREPARENTESE FECHAPARENTESE FIMDELINHA

/* Ordem de prioridade (baixo para cima) */
%left SOMA
%left MULTIPLICACAO DIVISAO
%left EXPONENCIACAO 
%left ABREPARENTESE FECHAPARENTESE

%%

/* Setenca global */
SENTENCA:
	SENTENCA EXPRESSAO FIMDELINHA {$$ = $2; printf("HLT\n");}
	|
	;

/* Expressoes */
EXPRESSAO:
	/* Tratamento dos numeros */
	INTEIRO {$$ = $1;}
	/* Expressao de SOMA */
	| EXPRESSAO SOMA EXPRESSAO {
		$$ = $1 + $3;
		printf("MOV B, %d\n", $1);
		printf("MOV C, %d\n", $3);
		printf("ADD B, C\n");
		printf("MOV A, B\n");
		printf("\n");
	}
	/* Expressao de MULTIPLICACAO */
	| EXPRESSAO MULTIPLICACAO EXPRESSAO {
		$$ = $1 * $3;
		printf("MOV B, %d\n", $1);
		printf("MOV A, %d\n", $3);
		printf("MUL B\n");
		printf("\n");
	}
	/* Expressao de DIVISAO */
	| EXPRESSAO DIVISAO EXPRESSAO {
		$$ = $1 / $3;
		printf("MOV B, %d\n", $1);
		printf("MOV A, %d\n", $3);
		printf("DIV B\n");
		printf("\n");
		/* Consideracao: Nao se pode ter $1 < $3 pois isso resultaria em um numero nao inteiro */
	}
	/* Expressao de EXPONENCIACAO */
	| EXPRESSAO EXPONENCIACAO EXPRESSAO {
		if($3 == 0){
			$$ = 1;
			printf("MOV A, 1\n");
			printf("\n");
		}
		else{

			for(i = 0; i<$3-1; i++){
				$$ = $$*$1;		
			}
			printf("MOV A, 1\n");
			printf("MOV B, 0\n");
			printf("MOV C, %d\n", $1);
			printf("MOV D, %d\n", $3);
			printf("LOOP: MUL C\n");
			printf("SUB D, 1\n");
			printf("CMP B, D\n");
			printf("JNZ LOOP\n");
			printf("\n");
		}
	}

	/* Prioridade dos parenteses */
	| ABREPARENTESE EXPRESSAO FECHAPARENTESE { $$ = $2;}
	;
	

%%

void yyerror(char *c){
	printf("Erro: %s\n",c);
}

int main(){
	yyparse();
	return 0;
}
