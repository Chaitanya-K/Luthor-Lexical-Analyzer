%{
	#include<stdio.h>
	#include<stdlib.h>
	#include<ctype.h>
	#include "symtab.c"

	int lc=1;
%}
%%
\n {lc++;fprintf(yyout,"\n");}
\"(\\.|[^"\\])*\" {fprintf(yyout,"<literal>"); } 
"auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"int"|"long"|"register"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while" { fprintf(yyout,"<%s>",yytext); } 
[A-Za-z_][A-Z_a-z0-9]* 	{ 
SYMBOL sym = searchins(yytext);
fprintf(yyout,"<id, %ld>",(long)sym);  }
[0-9]* {fprintf(yyout,"<num, %s>",yytext); }
">="|"<="|"!="|"=="|"+="|"-="|"*="|"++"|"--"|"/="|"->"|"||" {fprintf(yyout,"<%s>",yytext); }
"{"|"}"|";"|","|"["|"]"|"!"|"<"|">"|"?"|"."|"*"|"+"|"|"|"("|")"|"/"|"-"|"/"|"=" {fprintf(yyout,"<%s>",yytext); }


%%
int main()
{
	initsyms();
	char str[100];
	printf("Enter the file name:");
	scanf("%s",str);
	yyin=fopen(str,"r");
	yyout=fopen("tokens_output.txt","w");
	yylex();
	printf("Tokens successfully saved in tokens_output.txt \n Number of lines processed: %d",lc);
}
int yywrap()
{
	return 1;
}