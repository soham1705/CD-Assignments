%{

#include<stdio.h>
#include<stdlib.h>
int yylex(void);
void yyerror(char *s);
int i=0;
char p='p';
%}

%left '+' '-'
%left '*' '/'
%token STR

%%
prog : prog expr '\n' {printf("%c = %c\n",p,p-1);return 0;}
|
;
expr : STR
| expr '+' expr {if(i==0){ printf("%c = %d %c %d\n",p,$1,'+',$3); p++;i++;}
else{ printf("%c = %c %c %d\n",p,p-1,'+',$3);p++;}}
| expr '-' expr {if(i==0){ printf("%c = %d %c %d\n",p,$1,'-',$3); p++;i++;}
else{ printf("%c = %c %c %d\n",p,p-1,'-',$3);p++;}}
| expr '*' expr {if(i==0){ printf("%c = %d %c %d\n",p,$1,'*',$3); p++;i++;}
else{ printf("%c = %c %c %d\n",p,p-1,'*',$3);p++;}}
| expr '/' expr {if(i==0){ printf("%c = %d %c %d\n",p,$1,'/',$3); p++;i++;}
else{ printf("%c = %c %c %d\n",p,p-1,'/',$3);p++;}}
| '(' expr ')' {$$=$2;}
;
%%

void yyerror(char *s)
{
printf("%s\n",s);
}

int main()
{
yyparse();
return 0;
}
