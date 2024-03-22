//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 03/01/12, 14:15:48
//----------------------------------------------------
//Method: Object Method: [Bridge MHD NBIS].Bridge Input.ZZ9
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_02  //r003
	//Modified by: Charles Miller (3/1/12 14:15:49)
End if 
OBJECT SET VISIBLE:C603(*; "BridgeTemplate_@"; True:C214)
OBJECT SET VISIBLE:C603(*; "ForDesigner@"; False:C215)

FORM GOTO PAGE:C247(1)

//End Object Method: [Bridge MHD NBIS].Bridge Input.ZZ9