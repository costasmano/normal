
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 09/13/12, 15:31:37
//----------------------------------------------------
//Method: Object Method: [Inspections].Closed Insp Pg1.vDBIE
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_09  //r001 `` Added fn_ReturnName to return name as same code used in many places 
	//Modified by: Charles Miller (9/13/12 15:31:38)
	
End if 
If (Form event code:C388=On Printing Detail:K2:18)
	INSP_SetUpvDBIE
End if 
//End Object Method: [Inspections].Closed Insp Pg1.vDBIE

