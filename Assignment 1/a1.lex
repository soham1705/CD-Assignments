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
yyout=fopen("output.c","w+");
yylex();
fclose(yyout);
sys=system("indent -kr output.c");
}
