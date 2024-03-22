//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 02/12/13, 10:41:07
//----------------------------------------------------
//Method: Compiler_ScourCriticalItems
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_01  //r001 ` 
	//Modified by: Charles Miller (2/12/13 10:41:09)
	
End if 
If (Not:C34(Is compiled mode:C492))  //Place compiler directives here
	C_LONGINT:C283(bScourCritical)
End if 
ARRAY TEXT:C222(SC_SubItemforI113_atxt; 0)
ARRAY TEXT:C222(SC_SubItemforI113Key_atxt; 0)

//End Compiler_ScourCriticalItems

