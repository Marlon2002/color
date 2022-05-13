package modelo;
import compilerTools.TextColor;
import java.awt.Color;
%%
%class AnalizadorColor
%type TextColor
%char
%{
    private TextColor textColor(long start, int size, Color color){
        return new TextColor((int)start, size, color); 
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
    {Comentario} { return textColor(yychar, yylength(), new Color(146,146,146)); }
    {EspacioEnBlanco} { /*Ignorar*/ }
/* Excepciones */
"=" { return textColor(yychar, yylength(), new Color(0,0,0)); }

/* Estructura */
!DOCTYPE | html | head | body { return textColor(yychar, yylength(), new Color(2,15,212)); }

/* Signos */
"(" | ")" | "{" | "}" | "[" | "]" | "<" | ">" | "/" { return textColor(yychar, yylength(), new Color(0,219, 226)); }

/* Atributos */
id/= | class | lang | translate | title | data-* | accesskey | dir | style { return textColor(yychar, yylength(), new Color(7, 243, 0)); }

/* Obsoleto */
applet | acronym | bgsound | frame | frameset | noframes | hgroup | isindex |
 listing | xmp | noembed | strike | basefont | big | blink | center | font |
 marquee | multicol | nobr | spacer | tt | menu { return textColor(yychar, yylength(), new Color(159, 0, 12)); }


. { /*Ignorar*/ }