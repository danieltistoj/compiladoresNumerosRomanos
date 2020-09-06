package gt.edu.url.compiladores.numerosromanos;

%%
/*Esta clase va a indicar con que nombre va a generar el archivo Java*/
%class Operadores
/*Esto es para que la clase tenga su propio main*/
%standalone 
%line
%column


 /*Estas variables son expresiones regulares*/
I = "I"
V = "V"
In = {I}{1,3}
IV = {I}{V}
Ix = {I}{4}{I}*
IVx = {I}{I}+{V}+({I}+{V})*
Vx = {V}{V}+
IVx2 = {IV}+
RAMANO = ({In}|{IV}|{V})


%%
/*Seccione en donde indicamos como queremos encontrar la informacion*/
/*Esto indica que debe de hacer la variable, y es un codigo escrito en java*/
{RAMANO} {
System.out.println("Encontre un numero romano: "+yytext());
}
{Ix} {
System.out.println("Error de sintaxis, mas de tres 'I': "+yytext()+" En la linea: "+yyline+"En la columna: "+yycolumn);
}
{IVx} {
System.out.println("Error de sintaxis, para IV: "+yytext()+" En la linea: "+yyline+"En la columna: "+yycolumn);
}
{Vx} {
System.out.println("Error de sintaxis, para V: "+yytext()+" En la linea: "+yyline+"En la columna: "+yycolumn);
}
{IVx2} {
System.out.println("Error de sintaxis, para IV: "+yytext()+" En la linea: "+yyline+"En la columna: "+yycolumn);
}
/*Esto indica que hacer si encuentra un caracter que no se declarado, como se ha hecho con suma y con resta, esto funcionaria como un default en un swicht case en java   */
.  { }
