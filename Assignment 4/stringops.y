%{
void yyerror(char *s);
char *concatenate(char* a,char* b);
char *repeated_concat(char* a,int n);
char *prefix_of_length(char* a,int n);
char *suffix_of_length(char* a,int n);
#include <stdio.h>
#include <string.h>
%}

%union {int intval;char* strval;}
%token str num
%type <intval> num
%type <strval> str
%type <strval> op
%left '*' '%' '&'
%right '^'
%start S

%%

S   : S op        {}
    | op          {printf("%s\n",$<strval>$);}
    ;

op   : str '*' str {char* s=concatenate($1,$3);$$=s;}
     | str '^' num  {char* s=repeated_concat($1,$3);$$=s;}
     | str '%' num  {char* s=prefix_of_length($1,$3);$$=s;}
     | str '&' num  {char* s=suffix_of_length($1,$3);$$=s;}
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

char *prefix_of_length(char* a,int n)
{
    char *result=malloc(sizeof(char)*(n+1));
    int i;
    for(i=0;i<n;i++)
    {
        result[i]=a[i];
    }
    result[i]='\0';
    return result;
}

char *suffix_of_length(char* a,int n)
{
    char *result=malloc(sizeof(char)*(n+1));
    int i,ct=0;
    for(i=strlen(a)-n;i<strlen(a);i++)
    {
        result[ct]=a[i];
        ct++;
    }
    result[ct]='\0';
    return result;
}

int main(){
 yyparse();
}

void yyerror (char *s) {fprintf(stderr, "%s\n",s );}
