
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 09/13/12, 15:30:30
//----------------------------------------------------
//Method: Object Method: [Inspections].FC Pr (Pg 1).vDBIE
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_09  //r001 ` ` Added fn_ReturnName to return name as same code used in many places
	//Modified by: Charles Miller (9/13/12 15:30:31)
	Mods_2013_01  //r004 ` Make changes to printed inspection forms for differences in MBTA and non MBTA
	//Modified by: Charles Miller (1/24/13 11:10:06)
End if 

If (Form event code:C388=On Printing Detail:K2:18)
	INSP_SetUpvDBIE
End if 
//End Object Method: [Inspections].FC Pr (Pg 1).vDBIE

