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
	puts(s);
	return;
}

int main() {
	switch( yyparse() ){
	case 0:
		puts("Pertenece al LIC"); return 0;
	case 1:
		puts("No pertenece al LIC"); return 1;
	case 2:
		puts("Memoria insuficiente"); return 2;
	}
	return 0;
}


