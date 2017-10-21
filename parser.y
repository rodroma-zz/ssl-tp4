%{
    #include <stdio.h>
    #include <strings.h>
    #include "scanner.h"
    #define YYERROR_VERBOSE
%}
%code provides {
    void yyerror(const char* c);
    extern int elexemas;
    extern int yynerrs;
}
%defines "parser.h"
%output "parser.c"
%start programa
%define api.value.type{char *}
%token R_PROGRAMA IDENTIFICADOR CONSTANTE R_VARIABLES R_DEFINIR R_CODIGO R_LEER R_ESCRIBIR R_FIN ASIGNACION PUNTUACION
%left '-' '+'
%left '*' '/'
%precedence NEG

%%
programa : R_PROGRAMA cuerpo R_FIN { if(yynerrs || elexemas) YYABORT; };

cuerpo : R_VARIABLES listaDefiniciones R_CODIGO listaSentencias;

listaDefiniciones : definicion
                  | listaDefiniciones definicion
                  ;

definicion : R_DEFINIR IDENTIFICADOR ';' { printf("definir %s\n", $2); }
           | error ';'
           ;

listaSentencias : sentencia
                | listaSentencias sentencia 
                ;

sentencia : IDENTIFICADOR ASIGNACION expresion ';'  { printf("asignación\n"); }
          | R_LEER '(' listaIdentificadores ')' ';' { printf("leer\n"); }
          | R_ESCRIBIR '(' listaExpresiones ')' ';' { printf("escribir\n"); }
          | error ';'
          ;

listaIdentificadores : IDENTIFICADOR
                     | listaIdentificadores ',' IDENTIFICADOR
                     ;

listaExpresiones : expresion
                 | listaExpresiones ',' expresion
                 ;

expresion : expresion '*' expresion     { printf("multiplicación\n"); }
          | expresion '/' expresion     { printf("división\n"); }
          | expresion '+' expresion     { printf("suma\n"); }
          | expresion '-' expresion     { printf("resta\n"); }
          | '-' expresion   %prec NEG   { printf("inversión\n"); }
          | IDENTIFICADOR
          | CONSTANTE
          | '(' expresion ')'           { printf("paréntesis\n"); }
          ;

%%
int elexemas = 0;

/* Informa la ocurrencia de un error. */
void yyerror(const char *s){
	printf("Linea #%d: %s\n", yylineno, s);
	return;
}