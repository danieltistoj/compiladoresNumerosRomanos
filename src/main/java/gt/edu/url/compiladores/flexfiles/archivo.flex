package gt.edu.url.compiladores.numerosromanos;

%%
/*Esta clase va a indicar con que nombre va a generar el archivo Java*/
%class Operadores
/*Esto es para que la clase tenga su propio main*/
%standalone 
%line
%column


 /*Estas variables son expresiones regulares*/
I  = "I"
V  = "V"
X  = "X"
L  = "L"
C  = "C"
In = {I}{1,3}
Xn = {X}{1,3}
IV = {I}{V}
IX = {I}{X}
XL = {X}{L}
XC = {X}{C}
/*Errores de I - V*/
Ix   = {I}{4}{I}*
IVx  = {I}{I}+{V}+({I}+{V})*
Vx   = {V}{V}+
IVx2 = {IV}+
/*Errores con 10 39*/

RAMANO_I_V   = ({In}|{IV}|{V})                                      /*Numero de 1 a 5*/
ROMANO_VI_IX = ({V}{In}|{IX})                                       /*Numero de 6 a 9*/
ROMANO_X_MAS = {Xn}({ROMANO_VI_IX}|{RAMANO_I_V})?                   /*Numeros 10 a 39*/
ROMANO_XL    = {XL}({ROMANO_VI_IX}|{ROMANO_I_V})?                   /*Numeros de 40 a 49*/
ROMANO_L_MAS = {L}({ROMANO_VI_IX}|{ROMANO_I_V}|{ROMANO_X_MAS})?     /*De 50 a 89*/
ROMANO_XC    = {XC}({ROMANO_I_V}|{ROMANO_VI_IX})?                   /*De 90 a 99*/


%%
/*Seccione en donde indicamos como queremos encontrar la informacion*/
/*Esto indica que debe de hacer la variable, y es un codigo escrito en java*/
{RAMANO_I_V} {
System.out.println("Encontre un numero romano: "+yytext());
}

{ROMANO_VI_IX} {
System.out.println("Encontre un numero romano: "+yytext());
}

{ROMANO_X_MAS} { 
System.out.println("Encontre un numero romano: "+yytext());
}

{ROMANO_XL} {
System.out.println("Encontre un numero romano: "+yytext());
}

{ROMANO_L_MAS} {
System.out.println("Encontre un numero romano: "+yytext());
}

{ROMANO_XC} {
System.out.println("Encontre un numero romano: "+yytext());
}
/*Errores*/
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
