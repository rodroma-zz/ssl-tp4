%{
    #include <stdio.h>
    #include <string.h>
    #include "scanner.h"
    #define YYERROR_VERBOSE
    void yyerror(const char* c);
%}
%defines "parser.h"
%output "parser.c"
%start programa
%union {
    int ival;
    char *sval;
}
%token FDT R_PROGRAMA IDENTIFICADOR CONSTANTE R_VARIABLES R_DEFINIR R_CODIGO R_LEER R_ESCRIBIR R_FIN ASIGNACION PUNTUACION
%type <ival> FDT
%type <sval> IDENTIFICADOR
%type <ival> CONSTANTE
%type <sval> R_PROGRAMA
%type <sval> R_VARIABLES
%type <sval> R_DEFINIR
%type <sval> R_CODIGO
%type <sval> R_LEER
%type <sval> R_ESCRIBIR
%type <sval> R_FIN
%right <sval> ASIGNACION
%type <ival> PUNTUACION
%left '-' '+'
%left '*' '/'
%precedence NEG

%%
programa : R_PROGRAMA cuerpo R_FIN;

cuerpo : R_VARIABLES listaDefiniciones R_CODIGO listaSentencias;

listaDefiniciones : definicion
                  | listaDefiniciones definicion
                  ;

definicion : R_DEFINIR IDENTIFICADOR ';' { printf("definir %s\n", yytext); }
           | error ';'
           ;

listaSentencias : sentencia
                | listaSentencias sentencia 
                ;

sentencia : IDENTIFICADOR ASIGNACION expresion ';'  { printf("asignar\n"); }
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

expresion : termino
          | expresion '+' termino { printf("sumar\n"); }
          | expresion '-' termino { printf("restar\n"); }
          ;

termino : factor
        | termino '*' factor { printf("multiplicar\n"); }
        | termino '/' factor { printf("dividir\n"); }
        ;

factor : '-' primaria %prec NEG { printf("invertir\n"); }
       | primaria
       ;

primaria : IDENTIFICADOR
         | CONSTANTE
         | '(' expresion ')'
         ;

%%
