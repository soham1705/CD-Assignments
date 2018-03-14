%{
void yyerror(char *s);
char *concatenate(char* a,char* b);
#include <stdio.h>
#include <string.h>
%}
%union {
int intval;
char* strval;
}
%token STR NR
%type <intval>NR
%type <strval>STR
%type <strval>operatie
%left '*' '-'
%right '='
%start S
%%
S   : S operatie        {}
    | operatie          {printf("%s\n",$<strval>$);}
    ;

operatie    :   STR '*' STR {   char* s=concatenate($1,$3);
                                $$=s;}
            ;
%%

char *concatenate(char* a,char* b)
{
    char *result=malloc(sizeof(char)*(strlen(a)+strlen(b)+1));
    strcpy(result,a);
    strcat(result,b);
    return result;
}

int main(){
 yyparse();
}

void yyerror (char *s) {fprintf(stderr, "%s\n",s );}
