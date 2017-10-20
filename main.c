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

int main() {
	switch(yyparse()){
	case 0:
		printf("Compilación terminada con éxito.\nErrores sintácticos: %d - Errores léxicos: %d\n", yynerrs, elexemas); return 0;
	case 1:
		printf("Errores de compilación\nErrores sintácticos: %d - Errores léxicos: %d\n", yynerrs, elexemas); return 1;
	case 2:
		printf("Memoria insuficiente"); return 2;
	}
	return 0;
}
