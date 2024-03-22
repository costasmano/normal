
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 01/24/13, 11:55:06
//----------------------------------------------------
//Method: Object Method: [Inspections].RailRoutine Culvert.vDBIE
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_01  //r004 ` Make changes to printed inspection forms for differences in MBTA and non MBTA
	//Modified by: Charles Miller (1/24/13 11:10:06)
End if 

If (Form event code:C388=On Printing Detail:K2:18)
	INSP_SetUpvDBIE
End if 
//End Object Method: [Inspections].RailRoutine Culvert.vDBIE

