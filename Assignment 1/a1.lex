%{
#include <stdio.h>
int sys;
%}

%%
"/*"[^*]*"*/"|"/*"[^/]*"*/" ;
\/\/.* ;
("printf(".*((\/)(\/)).*) {ECHO;}
("printf(".*((\/)(\*)).*((\*)(\/))) {ECHO;}
%%

main()
{
yyout=fopen("intermediate.c","w+");
yylex();
fclose(yyout);
sys=system("indent -kr intermediate.c -o output.c");
}
