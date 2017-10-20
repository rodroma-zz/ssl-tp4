%{
#include <stdio.h>
#include <string.h>
#include "parser.h"
char buffer[200];
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
{letra}{letraDigito}*                                       {   yylval = strdup(yytext);
                                                                return IDENTIFICADOR;}
{letra}({letraDigito}|{invalido})*                          { elexemas++;
                                                              sprintf(buffer, "Error léxico: identificador inválido: %s", yytext); 
                                                              yyerror(buffer);}
{digito}+               	                                {   yylval = strdup(yytext);
                                                                return CONSTANTE; }
{digito}+{letraDigito}*                                     { elexemas++;
                                                              sprintf(buffer, "Error léxico: constante con sufijo inválido: %s", yytext);
                                                              yyerror(buffer);}
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
{invalido}+                                                 { elexemas++;
                                                              sprintf(buffer, "Error léxico: cadena desconocida: %s", yytext);
                                                              yyerror(buffer);}
{espacio}                                                   |
.                                                           {;}
