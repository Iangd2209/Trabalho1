%{
#include <stdio.h>

void yyerror(char *c);
int yylex(void);
int i = 0;
%}

%token INTEIRO SOMA SUBTRACAO MULTIPLICACAO EXPONENCIACAO ABREPARENTESE FECHAPARENTESE FIMDELINHA
%left SOMA
%left SUBTRACAO
%left MULTIPLICACAO
%left EXPONENCIACAO 
%left ABREPARENTESE FECHAPARENTESE



%%

SENTENCA:
	SENTENCA EXPRESSAO FIMDELINHA {$$ = $2;
				       printf("HLT\n");}
	|
	;

EXPRESSAO:
	INTEIRO {$$ = $1;}
	| EXPRESSAO SOMA EXPRESSAO {
		$$ = $1 + $3;
		int x, y; 
		if($1<0 && $3<0){
			x=-$1;
			y=-$3;
			printf("MOV B, %d\n", x);
			printf("MOV C, %d\n", y);
			printf("ADD B, C\n");
			printf("MOV A, B\n");
			printf("MOV B, 0\n");
			printf("SUB B, A\n");
			printf("MOV A, B\n");
			printf("\n");
		}
		else if($1<0){
			x=-$1;
			printf("MOV B, %d\n", x);
			printf("MOV C, %d\n", $3);
			printf("SUB C, B\n");
			printf("MOV A, C\n");
			printf("\n");
		}
		else if($3<0){
			y=-$3;
			printf("MOV B, %d\n", $1);
			printf("MOV C, %d\n", y);
			printf("SUB B, C\n");
			printf("MOV A, B\n");
			printf("\n");
		}
		else{
			printf("MOV B, %d\n", $1);
			printf("MOV C, %d\n", $3);
			printf("ADD B, C\n");
			printf("MOV A, B\n");
			printf("\n");
		}
	}
	| EXPRESSAO SUBTRACAO EXPRESSAO {
		$$ = $1 - $3;
		int x, y;
		if($1<0 && $3<0){
			x=-$1;
			y=-$3;
			printf("MOV B, %d\n", x);
			printf("MOV C, %d\n", y);
			printf("SUB C, B\n");
			printf("MOV A, C\n");
			printf("\n");
		}
		else if($1<0){
			x=-$1;
			printf("MOV B, %d\n", x);
			printf("MOV C, %d\n", $3);
			printf("ADD B, C\n");
			printf("MOV A, B\n");
			printf("MOV B, 0\n");
			printf("SUB B, A\n");
			printf("MOV A, B\n");
			printf("\n");
		}
		else if($3<0){
			y=-$3;
			printf("MOV B, %d\n", $1);
			printf("MOV C, %d\n", y);
			printf("ADD B, C\n");
			printf("MOV A, B\n");
			printf("\n");
		}
		else{
			printf("MOV B, %d\n", $1);
			printf("MOV C, %d\n", $3);
			printf("SUB B, C\n");
			printf("MOV A, B\n");
			printf("\n");
		}
	}
	| EXPRESSAO MULTIPLICACAO EXPRESSAO {
		$$ = $1 * $3;
		int x, y;
		if($1<0 && $3<0){
			x=-$1;
			y=-$3;
			printf("MOV B, %d\n", x);
			printf("MOV A, %d\n", y);
			printf("MUL B\n");
			printf("\n");
		}
		else if($1<0){
			x=-$1;
			printf("MOV B, %d\n", x);
			printf("MOV A, %d\n", $3);
			printf("MUL B\n");
			printf("MOV B, 0\n");
			printf("SUB B, A\n");
			printf("MOV A, B\n");
			printf("\n");
		}
		else if($3<0){
			y=-$3;
			printf("MOV B, %d\n", $1);
			printf("MOV A, %d\n", y);
			printf("MUL B\n");
			printf("MOV B, 0\n");
			printf("SUB B, A\n");
			printf("MOV A, B\n");
			printf("\n");
		}
		else{
			printf("MOV B, %d\n", $1);
			printf("MOV A, %d\n", $3);
			printf("MUL B\n");
			printf("\n");
		}
		
	}
	| EXPRESSAO EXPONENCIACAO EXPRESSAO {
		if($3 == 0){
			$$ = 0;
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
