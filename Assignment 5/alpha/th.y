%{

#include<stdio.h>
#include<string.h>
#include<stdlib.h>
void ThreeAddressCode();
char make_entry(char ,char, char);

int i=0;
char temp='A';
struct three_addr
{
	 char num1;
	 char num2;
	 char op;
};

%}

%union{char sym;}

%token <sym> LETTER NUMBER
%type <sym> expr
%left '-''+'
%right '*''/'

%%

statement: LETTER '=' expr  {make_entry($1,$3,'=');}
           | expr
	   ;

expr: expr '+' expr {$$ = make_entry($1,$3,'+');}
      | expr '-' expr {$$ = make_entry($1,$3,'-');}
      | expr '*' expr {$$ = make_entry($1,$3,'*');}
      | expr '/' expr {$$ = make_entry($1,$3,'/');}
      | '(' expr ')' {$$ = $2;}
      | NUMBER {$$ = $1;}
      | LETTER {$$ = $1;}
      ;

%%

struct three_addr code[20];

char make_entry(char num1,char num2,char op)
{
code[i].num1=num1;
code[i].num2=num2;
code[i].op=op;
i++;
temp++;
return temp;
}

void ThreeAddressCode()
{
  int count=0;
  temp++;
  while(count<i)
  {
  	printf("%c:",temp);

    if(isalpha(code[count].num1))
  		printf("%c",code[count].num1);
  	else
  		{printf("%c",temp);}

  	printf("%c",code[count].op);

  	if(isalpha(code[count].num2))
  		printf("%c",code[count].num2);
  	else
  		{printf("%c",temp);}

  	printf("\n");
  	count++;
  	temp++;
  }
}

main()
{
    yyparse();
    ThreeAddressCode();
}

yywrap()
{
    return 1;
}

yyerror(char *s)
{
  printf("%s",s);
  exit(0);
}
