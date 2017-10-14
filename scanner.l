%{
#include <stdio.h>
#include <string.h>
#include "parser.h"
%}
%option yylineno
%option outfile="scanner.c"
%option header-file="scanner.h"
%option noinput
%option nounput
letra [a-zA-Z]
digito [0-9]
invalido [[:punct:]]{-}[+*/(),;:=-]
espacio [[:space:]]
simbolo {valido}|{invalido}
letraDigito ({letra}|{digito})
%%
programa                                                    { return R_PROGRAMA; }
fin                                                         { return R_FIN; }
variables                                                   { return R_VARIABLES; }
codigo                                                      { return R_CODIGO; }
definir                                                     { return R_DEFINIR; }
leer                                                        { return R_LEER; }
escribir                                                    { return R_ESCRIBIR; }
{letra}{letraDigito}*                                       { return IDENTIFICADOR;}
{letra}({letraDigito}|{invalido})*                          { printf("Linea #%d: Error léxico: identificador inválido: %s\n", yylineno, yytext);}
{digito}+               	                                { return CONSTANTE; }
{digito}+{letraDigito}*                                     { printf("Linea #%d: Error léxico: constante con sufijo inválido: %s\n", yylineno, yytext);}
":="                                                        { return ASIGNACION; }
"//".*\n                                                    {;}
"+"                                                         { return '+'; }
"-"                                                         { return '-'; }
"*"                                                         { return '*'; }
"/"                                                         { return '/'; }
"("                                                         { return '('; }
")"                                                         { return ')'; }
","                                                         { return ','; }
";"                                                         { return ';'; }
{invalido}+                                                 { printf("Linea #%d: Error léxico: cadena desconocida: %s\n", yylineno, yytext);}
{espacio}                                                   |
.                                                           {;}
