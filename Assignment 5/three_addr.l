%{
#include <stdio.h>
#include <stdlib.h>
//#include "y.tab.h"
%}

%%

"exit"                  {exit(EXIT_SUCCESS);}
[0-9]+                  {printf("Number\n");}
[a-zA-Z]                {printf("Letter\n");}
[\*\/<>=+-\[\]]           {printf("Symbol\n");}
[ \t\n]                 ;
.                      {return yytext[0];}

%%

int yywrap()
{
    return 1;
}
