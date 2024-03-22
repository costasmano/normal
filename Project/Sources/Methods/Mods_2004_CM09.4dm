//%attributes = {"invisible":true}
//Mods_2004_CM09

//12-Oct-2004

//Modified Method :
//G_InitInspVars 
//  `Added declaration of var vRd414
//M_DeficientElementRpt 
//  `Fixed coding errors.
//Check_DupInsp 
//  `Modified to use set query destination into variable instead of saving sets. 
//ut_MessageDia 
//  `Added comments
//ut_StartMessage 
//  `Added externsion .txt to file name.

//Modified form:
// [Inspections];"Routine Pr Pg 2" 
//  `Added variables vT414, vRd414, vR414, vD414

//Modified form method:
//[Inspections];"Routine Pr Pg 2" 
//  `Added code to take into account use of Blank Element 9 (Elmt Id=414)
//[Bridge MHD NBIS];"Pontis"
//Fixed incorrect user Group name in Duplicate and Add buttons. Adjusted 
//code in these buttons to use variable vAddBlank
