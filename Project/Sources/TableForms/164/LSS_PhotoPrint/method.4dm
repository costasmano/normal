
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 03/10/15, 12:32:53
//----------------------------------------------------
//Method: Form Method: [LSS_Inspection]LSS_PhotoPrint
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (3/10/15 12:33:00)
	
End if 
Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		vPageNo:=vPageNo+1
End case 
//End Form Method: [LSS_Inspection]LSS_PhotoPrint

