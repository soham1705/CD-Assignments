%{

  #include<stdio.h>
  #include<string.h>
  #include<stdlib.h>
void ThreeAddressCode();
char AddToTable(char ,char, char);

  int ind=0;
  char temp='A';
  struct incod
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

statement: LETTER '=' expr  {AddToTable((char)$1,(char)$3,'=');}
           | expr
	   ;

expr: expr '+' expr {$$ = AddToTable((char)$1,(char)$3,'+');}
      | expr '-' expr {$$ = AddToTable((char)$1,(char)$3,'-');}
      | expr '*' expr {$$ = AddToTable((char)$1,(char)$3,'*');}
      | expr '/' expr {$$ = AddToTable((char)$1,(char)$3,'/');}
      | '(' expr ')' {$$ = (char)$2;}
      | NUMBER {$$ = $1;}
      | LETTER {$$ = (char)$1;}
      ;

%%

yyerror(char *s)
{
  printf("%s",s);
  exit(0);
}

struct incod code[20];

int id=0;

char AddToTable(char num1,char num2,char op)
{
code[ind].num1=num1;
code[ind].num2=num2;
code[ind].op=op;
ind++;
temp++;
return temp;
}

void ThreeAddressCode()
{
int cnt=0;
temp++;
while(cnt<ind)
{
	printf("%c:",temp);


        if(isalpha(code[cnt].num1))
		printf("%c",code[cnt].num1);
	else
		{printf("%c",temp);}

	printf("%c",code[cnt].op);

	if(isalpha(code[cnt].num2))
		printf("%c",code[cnt].num2);
	else
		{printf("%c",temp);}

	printf("\n");
	cnt++;
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
