package br.ufpe.cin.if688.jflex;

%%

/*
A linha atual pode ser acessada por yyline
e a coluna atual com yycolumn.
*/
%line
%column

/* Se quisermos 'interfacear' com um parser gerado pelo sistema CUP
%cup
*/

//encoding
%unicode

// faz com que a classe tenha uma função main e torna possivel que a classe gerada seja usada como reconhecedor
%standalone

//nomeia a classe
%class MiniJava

/*
Declarações

código dentro de %{ e %}, é copiado para a classe gerada.
a ideia é utilizar este recurso para declarar atributos e métodos usados nas ações
*/
%{
int qtdeID=0;
%}


%eof{
System.out.println("Quantidade de Identificadores encontrados: "+qtdeID);
%eof}

/*-*
 * PADROES NOMEADOS:
 */
letter          = [A-Za-z]
digit           = [0-9]
integer         = {digit}+
alphanumeric    = {letter}|{digit}
identifier      = {letter}({alphanumeric})*
whitespace      = [ \n \t \r \f]
resWord = "boolean"|"class"|"public"|"extends"|"static"|"void"|"main"|"String"|"int"|"while"|"if"|"else"|"return"|"length"|"true"|"false"|"this"|"new" | "System.out.println"
operator        = "&&"|"<"|"=="|"!="|"+"|"-"|"*"|"!"
pontuation      =  ";" |"."| ","| "="|"(" |")" |"{" |"}" |"[" |"]"

%%
/**
 * REGRAS LEXICAS:
 */

and             { System.out.println("Token AND"); }
"or"			{ System.out.println("Token OR"); }
"*"             { System.out.println("Token *"); }
"+"             { System.out.println("Token +"); }
"-"             { System.out.println("Token -"); }
"/"             { System.out.println("Token /"); }
"("             { System.out.println("Token ("); }
")"             { System.out.println("Token )"); }
{pontuation}    { System.out.println("token gerado foi um delimitador: '"+ yytext() +"'na linha:" +yyline+ ", coluna: "+yycolumn);}
{resWord}       { System.out.println("token gerado foi um reservado: '"+ yytext() +"'na linha:" +yyline+ ", coluna: "+yycolumn);}
{operator}      { System.out.println("token gerado foi um operador: '"+ yytext() +"'na linha:" +yyline+ ", coluna: "+yycolumn);)}
{identifier}    { qtdeID++; System.out.println("Token ID ("+yytext()+")"); }
{integer}       { System.out.println("Token INT ("+yytext()+")"); }
{whitespace}    { /* Ignorar whitespace. */ }
.               { System.out.println("Illegal char, '" + yytext() +
                    "' line: " + yyline + ", column: " + yycolumn); }

