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



ROMANO_I_V   = ({In}|{IV}|{V})                                      /*Numero de 1 a 5*/
ROMANO_VI_IX = ({V}{In}|{IX})                                       /*Numero de 6 a 9*/
ROMANO_X_MAS = {Xn}({ROMANO_VI_IX}|{ROMANO_I_V})?                   /*Numeros 10 a 39*/
ROMANO_XL    = {XL}({ROMANO_VI_IX}|{ROMANO_I_V})?                   /*Numeros de 40 a 49*/
ROMANO_L_MAS = {L}({ROMANO_VI_IX}|{ROMANO_I_V}|{ROMANO_X_MAS})?     /*De 50 a 89*/
ROMANO_XC    = {XC}({ROMANO_I_V}|{ROMANO_VI_IX})?                   /*De 90 a 99*/

/*Errores de I - V*/
Ix   = {I}{4}{I}*                                               /*Error donde: IIIII,IIIIIIII */
IVx  = {I}{I}+{V}+({I}+{V})*                                    /*Error donde: IIV, IIIIIVI, IIVVVVIVIVIVIIVIVVV*/
Vx   = {V}{V}+                                                  /*Error donde: VV, VVVVVVVVVVV*/
IVx2 = {IV}+                                                    /*Errore donde: IVIVIVIVIV, IVIV*/
/*Fin*/

/*Errores con VI - IX*/
VIx = {V}{Ix}                                                   /*Error en donde puede ser VIIII - VIIIIIIIIIII...*/
IXn = {I}+{IX}                                                  /*Error de 9 IIIIX*/
nIXn = {I}*{IX}{I}+                                             /*Error de forma IIIXIIII, IXIIIIIII, IXI*/
/*Fin*/

/*Errores con 10 a 39*/
/*Error 1*/
ERROR_1_0 = {X}{4}{X}*({ROMANO_VI_IX}|{ROMANO_I_V})?                /*Error donode: XXXX, XXXXXXXXXXXXXX. Y lo demas bien*/
ERROR_2_0 = {Xn}({VIx}|{Ix}|{IVx}|{Vx}|{IVx2}|{IXn}|{nIXn})         /*Error donde: X [Algun error (VI-IX)] | [Algun error (I-V)],XX[Algun error (VI-IX)] | [Algun error (I-V)],XXX[Algun error (VI-IX)] | [Algun error (I-V)]*/

/*Fin*/
/*Erroes de 40 a 50*/
ERROR_1_1 = {X}+{XL}{L}*({ROMANO_VI_IX}|{ROMANO_I_V})?             /*Error donde: XXLLLLLL, XXLLLLLLLL, XXL. Y todo lo demas bien*/
ERROR_2_1 = {XL}{L}+({ROMANO_VI_IX}|{ROMANO_I_V})?                 /*Error donde: XLL, XLLLLLLLLLLL. Y todo lo demas bien*/

%%
/*Seccione en donde indicamos como queremos encontrar la informacion*/
/*Esto indica que debe de hacer la variable, y es un codigo escrito en java*/
/*Validacion de 1 al 5*/
{ROMANO_I_V} {
System.out.println("Encontre un numero romano: "+yytext());
}
/*Validacion de 6 al 9*/
{ROMANO_VI_IX} {
System.out.println("Encontre un numero romano: "+yytext());
}
/*Validacion de 10 al 39*/
{ROMANO_X_MAS} { 
System.out.println("Encontre un numero romano: "+yytext());
}
/*Validacion de 40 al 50*/
{ROMANO_XL} {
System.out.println("Encontre un numero romano: "+yytext());
}
/*Validacion de 50 al 89*/
{ROMANO_L_MAS} {
System.out.println("Encontre un numero romano: "+yytext());
}
/*Validacion de 90 a 99*/
{ROMANO_XC} {
System.out.println("Encontre un numero romano: "+yytext());
}
/*Validacion del 100*/
{C} {
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
{VIx} {
System.out.println("Error de sintaxis, para IV: "+yytext()+" En la linea: "+yyline+"En la columna: "+yycolumn);
}
{IXn} {
System.out.println("Error de sintaxis, para IV: "+yytext()+" En la linea: "+yyline+"En la columna: "+yycolumn);
}
{nIXn} {
System.out.println("Error de sintaxis, para IV: "+yytext()+" En la linea: "+yyline+"En la columna: "+yycolumn);
}
/*Esto indica que hacer si encuentra un caracter que no se declarado, como se ha hecho con suma y con resta, esto funcionaria como un default en un swicht case en java   */
.  { }
