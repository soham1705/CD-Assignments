%{
void yyerror(char *s);
char *concatenate(char* a,char* b);
char *repeated_concat(char* a,int n);
#include <stdio.h>
#include <string.h>
%}

%union {int intval;char* strval;}
%token STR NR
%type <intval>NR
%type <strval>STR
%type <strval>op
%left '*'
%right '^'
%start S

%%

S   : S op        {}
    | op          {printf("%s\n",$<strval>$);}
    ;

op   : STR '*' STR {char* s=concatenate($1,$3);$$=s;}
     | STR '^' NR  {char* s=repeated_concat($1,$3);$$=s;}
     ;


%%

char *concatenate(char* a,char* b)
{
    char *result=malloc(sizeof(char)*(strlen(a)+strlen(b)+1));
    strcpy(result,a);
    strcat(result,b);
    return result;
}

char *repeated_concat(char* a,int n)
{
    char* a_init=malloc(sizeof(char)*(strlen(a)));
    a_init=a;
    int i;
    for(i=1;i<n;i++)
    {
        a=concatenate(a,a_init);
    }
    return a;
}

int main(){
 yyparse();
}

void yyerror (char *s) {fprintf(stderr, "%s\n",s );}
