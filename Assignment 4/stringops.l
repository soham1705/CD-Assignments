%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
%}

%%

"exit"          {exit(EXIT_SUCCESS);}
[0-9]+          {yylval.intval=atoi(yytext); return num;}
[a-zA-Z]+       {yylval.strval=strdup(yytext); return str;}
[ \t\n]         ;
.               {return yytext[0];}

%%

int yywrap()
{
    return 1;
}
