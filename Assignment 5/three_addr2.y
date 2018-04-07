%{
#include<stdio.h>
int aaa;
%}

%union{char dval;}

%token <dval> NUM
%type <dval> E
%left '+' '-'
%left '*' '/' '%'

%%
statement : E {printf("\nt = %c \n",$1);}
          ;

E : E '+' E
    {
        char word[10000]="t";
        char *test=gencode(word,$1,'+',$3);
        $$=test;

    }
  | E '-' E
    {
        char word[10000]="t";
        char *test=gencode(word,$1,'-',$3);
        $$=test;
    }
  | E '%' E
    {
        char word[10000]="t";
        char *test=gencode(word,$1,'%',$3);
        $$=test;
    }
  | E '*' E
    {
        char word[10000]="t";
        char *test=gencode(word,$1,'*',$3);
        $$=test;
    }
  | E '/' E
    {
        char word[10000]="t";
        char *test=gencode(word,$1,'/',$3);
        $$=test;
    }
  | '(' E ')'
    {
        $$=$2;
    }
  | NUM
    {
        $$=$1;
    }
  ;
%%
