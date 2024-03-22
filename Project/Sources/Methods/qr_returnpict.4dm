//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 05/19/15, 16:50:17
//----------------------------------------------------
//Method: qr_returnpict
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (5/19/15 16:50:18)
	C_PICTURE:C286(qr_returnpict; $0)
	
End if 
C_PICTURE:C286($0)

BLOB TO PICTURE:C682([LSS_Photos:166]LSS_Photo_blb:5; $0)


//End qr_returnpict

