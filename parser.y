%{
    #include <stdio.h>
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
%token FDT IDENTIFICADOR CONSTANTE R_PROGRAMA R_VARIABLES R_DEFINIR R_CODIGO R_LEER R_ESCRIBIR R_FIN ASIGNACION PUNTUACION
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
                  | definicion listaDefiniciones
                  ;

definicion : R_DEFINIR IDENTIFICADOR ';';

listaSentencias : sentencia
                | sentencia listaSentencias
                ;

sentencia : IDENTIFICADOR ASIGNACION expresion ';'
          | R_LEER '(' listaIdentificadores ')' ';'
          | R_ESCRIBIR '(' listaExpresiones ')' ';'
          ;

listaIdentificadores : IDENTIFICADOR
                     | IDENTIFICADOR ',' listaIdentificadores
                     ;

listaExpresiones : expresion
                 | expresion ',' listaExpresiones
                 ;

expresion : termino
          | expresion '+' termino
          | expresion '-' termino
          ;

termino : factor
        | termino '*' factor
        | termino '/' factor
        ;

factor : '-' primaria %prec NEG
       | primaria
       ;

primaria : IDENTIFICADOR
         | CONSTANTE
         | '(' expresion ')'
         ;

%%
