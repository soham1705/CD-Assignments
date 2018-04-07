%{
void yyerror(char *s);
#include <stdio.h>
#include <string.h>
%}

%union {int intval;char* strval;}

%token str num
%type <intval> num
%type <strval> str

%start S

%%
