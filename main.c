/*
Profesor: Eduardo Zúñiga
Curso: K2055
Grupo: 1
TP: 4
Integrantes:
				Luna, Brian Damian				155.369-0
				Martin, Rodrigo Leonardo		160.255-0
				Miravalles, Emanuel Gonzalo		127.099-0
				de Beruti, Nicolas Alejandro	149.700-5
*/
#include <stdio.h>
#include "scanner.h"
#include "parser.h"

char* token_names[] = { "Fin de Archivo" ,
						"Identificador",
						"Constante",
						"Programa",
						"Variables",
						"Definir",
						"Código",
						"Leer",
						"Escribir",
						"Fin",
						"Asignación",
						"Puntuación"	
						};

/* Informa la ocurrencia de un error. */
void yyerror(const char *s){
	printf("Linea #%d: %s\n", yylineno, s);
	return;
}

int main() {
	switch( yyparse() ){
	case 0:
		printf("Compilación finalizada con éxito.\nErrores sintácticos: 0\tErrores léxicos: 0\n"); return 0;
	case 1:
		printf("Errores de compilación\nErrores sintácticos: 0\tErrores léxicos: 0\n"); return 1;
	case 2:
		printf("Memoria insuficiente"); return 2;
	}
	return 0;
}


