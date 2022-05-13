package modelo;
import compilerTools.Token;
%%
%class Analizador
%type Token
%line
%column
%{
    private Token token(String lexeme, String lexicalComp, int line, int column) {
        return new Token(lexeme,lexicalComp, line+1, column+1);
    }
%}
    TerminadorDeLinea = \r|\n|\r\n
    EntradaDeCaracter = [^\r\n]
    EspacioEnBlanco = {TerminadorDeLinea} | [ \t\f]
    ComentarioTradicional = "/*" [^*] ~"*/" | "/*" "*"+ "/"
    FinDeLineaComentario = "//" {EntradaDeCaracter}* {TerminadorDeLinea}?
    ContenidoComentario = ( [^*] | \*+ [^/*] )*
    ComentarioDeDocumentacion = "/**" {ContenidoComentario} "*"+ "/"

    /* Comentario */
    Comentario = {ComentarioTradicional} | {FinDeLineaComentario} | {ComentarioDeDocumentacion}

    /* Identificador */
    Letra = [A-Za-zÑñ_ÁÉÍÓÚáéíóúÜü]
    Digito = [0-9]
    Identificador = {Letra}({Letra}|{Digito})*

    /* Número */
    Numero = 0 | [1-9][0-9]*
%%

    /* Comentarios o espacios en blanco */
    {Comentario}|{EspacioEnBlanco} { /*Ignorar*/ }

/* Identificador */
\${Identificador} { return token(yytext(), "IDENTIFICADOR", yyline, yycolumn); }

/* Tipos de dato*/
número |
color { return token(yytext(), "TIPO_DATO", yyline, yycolumn); }

/* Número */
{Numero} { return token(yytext(), "NUMERO", yyline, yycolumn); }

/* Colores */
#[{Letra}|{Digito}]{6} { return token(yytext(), "COLOR", yyline, yycolumn);}

/*Operadores de agrupación*/
"(" { return token(yytext(), "PARENTESIS_A", yyline, yycolumn);}
")" { return token(yytext(), "PARENTESIS_C", yyline, yycolumn);}
"{" { return token(yytext(), "LLAVE_A", yyline, yycolumn);}
"}" { return token(yytext(), "LLAVE_C", yyline, yycolumn);}
 
. { return token(yytext(), "ERROR", yyline, yycolumn); }