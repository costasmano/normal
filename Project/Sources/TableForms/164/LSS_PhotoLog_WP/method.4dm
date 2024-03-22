//Method: Form Method: [LSS_Inspection];"LSS_PhotoLog_WP"
//Description
//
// Parameters
If (False:C215)
	
	//----------------------------------------------------
	//User name (OS): administrator
	//Date and time: 03/10/15, 12:32:12
	//----------------------------------------------------
	
	// Modified by: Costas Manousakis (8/15/22)
	Mods_2022_09_bug
	//change line ht to 99% for MacOS
End if 
Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		vPageNo:=vPageNo+1
		C_OBJECT:C1216(INSP_Comments_WP)
		C_POINTER:C301($area_)
		$area_:=OBJECT Get pointer:C1124(Object named:K67:5; "WParea")
		$area_->:=INSP_Comments_WP
		
		If (Is macOS:C1572)
			WP SET ATTRIBUTES:C1342($area_->; wk line height:K81:51; "99%")
		End if 
		
End case 
//End Form Method: [LSS_Inspection];"LSS_PhotoLog_WP"