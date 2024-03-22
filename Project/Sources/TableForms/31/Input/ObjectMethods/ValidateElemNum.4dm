
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 12/20/12, 11:28:02
//----------------------------------------------------
//Method: Object Method: [Inspection Type].Input.Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_12  //r001 ` 
	//Modified by: Charles Miller (12/20/12 11:28:04)
	
End if 
OBJECT SET ENABLED:C1123(bzOK; True:C214)  // Command Replaced was o_ENABLE BUTTON 
If (Not:C34(insp_ValidateElementNumbers))
	OBJECT SET ENABLED:C1123(bzOK; False:C215)  // Command Replaced was o_DISABLE BUTTON 
End if 
//End Object Method: [Inspection Type].Input.Button

