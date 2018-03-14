%{
void yyerror(char *s);
char *concatenate(char* a,char* b);
char *repeated_concat(char* a,int n);
char *prefix_of_length(char* a,int n);
char *suffix_of_length(char* a,int n);
char *is_prefix(char *a,char *b);
char *is_suffix(char *a,char *b);
char *is_substring(char *a,char *b);
#include <stdio.h>
#include <string.h>
%}

%union {int intval;char* strval;}
%token str num
%type <intval> num
%type <strval> str
%type <strval> op

%left '*'
%left '%'
%left '&'
%left '~'
%left '@'
%left '#'
%right '?'
%right '^'
%start S

%%

S   : S op      {}
    | op        {}
    ;

op   : '?' str      {int size=strlen($2);$<intval>$=size;printf("%d\n",$$);}
     | str '^' num  {char* s=repeated_concat($1,$3);$$=s;printf("%s\n",$$);}
     | str '*' str {char* s=concatenate($1,$3);$$=s;printf("%s\n",$$);}
     | str '%' num  {char* s=prefix_of_length($1,$3);$$=s;printf("%s\n",$$);}
     | str '&' num  {char* s=suffix_of_length($1,$3);$$=s;printf("%s\n",$$);}
     | str '~' str  {char* s=is_prefix($1,$3);$$=s;printf("%s\n",$$);}
     | str '@' str  {char* s=is_suffix($1,$3);$$=s;printf("%s\n",$$);}
     | str '#' str  {char* s=is_substring($1,$3);$$=s;printf("%s\n",$$);}
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

char *is_prefix(char *a,char *b)
{
    int i;
    for(int i=0;a[i]!='\0';i++)
    {
        if(a[i]!=b[i])
        {
            return "False";
        }
    }
    return "True";
}

char *is_suffix(char *a,char *b)
{
    int i;
    for(int i=strlen(a);i>=0;i--)
    {
        if(a[i]!=b[i+strlen(b)-strlen(a)])
        {
            return "False";
        }
    }
    return "True";
}

char *is_substring(char *a,char *b)
{
    if(strstr(b,a))
      return "True";
    return "False";
}

int main(){
  yyparse();
}

void yyerror (char *s) {fprintf(stderr, "%s\n",s );}
