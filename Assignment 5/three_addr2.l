%{
#include<stdio.h>
#include"y.tab.h"
int k=1;
%}

%%

[0-9]+    {yylval.dval=yytext[0];return NUM;}
\n        {return 0;}
.         {return yytext[0];}

%%

void yyerror(char* str)
{
        printf("\n%s",str);
}

char *gencode(char first,char op,char second)
{
    char word[10000];
    word="t";
    char temp[10];
    sprintf(temp,"%d",k);
    strcat(word,temp);
    k++;
    printf("%s = %c %c %c\n",word,first,op,second);

    return word; //Returns variable name like t1,t2,t3... properly
}

int yywrap()
{
    return 1;
}

main()
{
    yyparse();
    return 0;
}
