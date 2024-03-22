//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 02/28/12, 17:09:47
//----------------------------------------------------
//Method: Object Method: [Bridge MHD NBIS].BridgeTemplate.ZZ9
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_02  //r003
	//Modified by: Charles Miller (2/28/12 17:09:48)
	// Modified by: Costas Manousakis-(Designer)-(5/3/12 10:16:43)
	Mods_2012_05
	//  `Release all other tables
End if 
If (FORM Get current page:C276=1)
	CANCEL:C270
	
Else 
	OBJECT SET VISIBLE:C603(*; "ForDesigner@"; False:C215)
	FORM GOTO PAGE:C247(1)
End if 
G_CloseAllTables(->[Bridge MHD NBIS:1])  //Release all other tables
//End Object Method: [Bridge MHD NBIS].BridgeTemplate.ZZ9