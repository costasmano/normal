
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/02/15, 16:15:03
//----------------------------------------------------
//Method: Object Method: [LSS_Photos].Input.bNext 
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/2/15 16:15:04)
	
	Mods_2018_06_bug  //Make changes to [LSS_Photos] input to try and fix problems with blank [Activity Log] records
	//Modified by: Chuck Miller (6/5/18 15:10:36)
	
End if 
Case of 
	: ((Form event code:C388=On Mouse Enter:K2:33) | (Form event code:C388=On Mouse Enter:K2:33))
		C_TEXT:C284($Tip_txt)
		$Tip_txt:="Next Image (PgDn)"
		ut_GenericHelp_OM($Tip_txt)
		
	: (Form event code:C388=On Clicked:K2:4)
		FM_SavePhotoInput
		USE NAMED SELECTION:C332("PhotoSet")
		LSS_SelectedRow_L:=LSS_SelectedRow_L+1
		LSS_PhotoTraverseRecords
		
End case 
//End Object Method: [LSS_Photos].Input.bNext