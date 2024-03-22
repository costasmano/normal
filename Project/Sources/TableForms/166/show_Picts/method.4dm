
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 05/19/15, 17:05:19
//----------------------------------------------------
//Method: Form Method: [LSS_Photos]show_Picts
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (5/19/15 17:05:21)
	
End if 
If (Form event code:C388=On Display Detail:K2:22)
	
	BLOB TO PICTURE:C682([LSS_Photos:166]LSS_Photo_blb:5; LSS_DMeterPicture_pct)
	LSS_Print_L:=BLOB size:C605([LSS_Photos:166]LSS_Photo_blb:5)
	
End if 
//End Form Method: [LSS_Photos]show_Picts

