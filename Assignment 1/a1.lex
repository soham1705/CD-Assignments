%{
#include <stdio.h>
int i;
%}

%%
"/*"[^*]*"*/"|"/*"[^/]*"*/" ;
\/\/.* ;
("printf(".*((\/)(\/)).*) {ECHO;}
("printf(".*((\/)(\*)).*((\*)(\/))) {ECHO;}
%%

main(int argc,char *argv[])
{
argv[2] = "inter.c";
yyout=fopen(argv[2],"w+");
yylex();
fclose(yyout);
i=system("indent -kr inter.c -o output.c");
}
