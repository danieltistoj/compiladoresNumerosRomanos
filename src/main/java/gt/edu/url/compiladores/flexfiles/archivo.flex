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


/*Forma correcta de los numeros*/
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
CONJUNTO_ERROR = ({VIx}|{Ix}|{IVx}|{Vx}|{IVx2}|{IXn}|{nIXn})    /*Conjunto de errores de I - V y de VI IX*/ /*CASE*/
/*Fin*/

/*Errores con 10 a 39*/
/*Error 1*/
ERROR_1_0 = {X}{4}{X}*({ROMANO_VI_IX}|{ROMANO_I_V})?                /*Error donode: XXXX, XXXXXXXXXXXXXX. Y lo demas bien*/ /*CASE*/
ERROR_2_0 = {Xn}{CONJUNTO_ERROR}                                    /*Error donde: X [Algun error (VI-IX)] | [Algun error (I-V)],XX[Algun error (VI-IX)] | [Algun error (I-V)],XXX[Algun error (VI-IX)] | [Algun error (I-V)]*/ /*CASE*/

/*Fin*/
/*Erroes de 40 a 50*/
ERROR_1_1 = {X}+{XL}{L}*({ROMANO_VI_IX}|{ROMANO_I_V})?             /*Error donde: XXLLLLLL, XXLLLLLLLL, XXL. Y todo lo demas bien*/ /*CASE*/
ERROR_2_1 = {XL}{L}+({ROMANO_VI_IX}|{ROMANO_I_V})?                 /*Error donde: XLL, XLLLLLLLLLLL. Y todo lo demas bien*/ /*CASE*/
ERROR_3_1 = {XL}{CONJUNTO_ERROR}                                   /*Error donde: XL [Error de I - IX]*/ /*CASE*/
/*Fin*/

/*Errores de 50 al 89*/
ERROR_1_2 = {L}{L}+({ROMANO_VI_IX}|{ROMANO_I_V}|{ROMANO_X_MAS})?   /*Error donde: LLLLLLLL, LL[Todo lo demas bien]*/ /*CASE*/
ERROR_2_2 = {L}({ERROR_1_0}|{ERROR_2_0})                           /*Error donde: L [Errores tipo: ERROR_1_0 ó ERROR_2_0]*/ /*CASE*/
/*Fin*/

/*Errorres de 90 - 100*/
ERROR_1_3 = {X}+{XC}{C}*({ROMANO_VI_IX}|{ROMANO_I_V})?              /*Error donde: XXC [lo demas bien], XXCCCC [lo demas bien], XXCCC*/ /*CASE*/
ERROR_2_3 = {XC}{C}+({ROMANO_VI_IX}|{ROMANO_I_V})?                  /*Error donde: XCCCCC, XCC [lo demas bien]*/ /*CASE*/
ERROR_3_3 = {XC}({ERROR_1_0}|{ERROR_2_0})                           /*Error donde: XC [Errores tipo: ERROR_1_0 ó ERROR_2_0]*/ /*CASE*/
ERROR_4_3 = {C}{C}+
/*Fin*/
%%

/**********INICIO DE LOS CASE**********/

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

{CONJUNTO_ERROR} {
System.out.println("Error en el numero romano: "+yytext()+"\nEn la linea: "+yyline+"\nEn la columna: "+yycolumn);
}
/*Esto indica que hacer si encuentra un caracter que no se declarado, como se ha hecho con suma y con resta, esto funcionaria como un default en un swicht case en java   */
.  { }
