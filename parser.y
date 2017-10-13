%{
#include <stdio.h>

%}
%defines "parser.h"
%output "parser.c"
%start programa
%union {
    int ival;
    char *sval;
}
%token <ival> FDT
%token <sval> IDENTIFICADOR
%token <ival> CONSTANTE
%token <sval> R_PROGRAMA
%token <sval> R_VARIABLES
%token <sval> R_DEFINIR
%token <sval> R_CODIGO
%token <sval> R_LEER
%token <sval> R_ESCRIBIR
%token <sval> R_FIN
%token <sval> ASIGNACION
%token <ival> PUNTUACION
%token <ival> TOPE

COMO SE USA %code provides {} + %define ???????

%%
programa : PROGRAMA cuerpo FIN;

cuerpo : VARIABLES listaDefiniciones CODIGO listaSentencias;

listaDefiniciones : definicion
                  | definicion listaDefiniciones
                  ;            RESOLVER RECURSION A DERECHA? IMPORTA?

definicion : DEFINIR identificador ';';
listaSentencias : sentencia
                | sentencia listaSentencias
                ;

sentencia : identificador ':=' expresion ';'
          | LEER '(' listaIdentificadores ')' ';'
          | ESCRIBIR '(' listaExpresiones ')' ';'
          ;

listaIdentificadores : identificador
                     | identificador ',' listaIdentificadores
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

factor : '-' primaria
       | primaria
       ;

primaria : identificador
         | constante
         | '(' expresion ')'
         ;
%%
Epílogo