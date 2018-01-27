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

main(int argc,char *argv[])
{
argv[0] = "intermediate.c";
yyout=fopen(argv[0],"w+");
yylex();
fclose(yyout);
sys=system("indent -kr intermediate.c -o output.c");
}
