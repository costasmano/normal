
// ----------------------------------------------------
// User name (OS): administrator
// Date and time: 10/14/14, 14:10:46
// ----------------------------------------------------
// Method: Object Method: [LSS_Photos].Input.bFirst 
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2018_06_bug  //Make changes to [LSS_Photos] input to try and fix problems with blank [Activity Log] records
	//Modified by: Chuck Miller (6/5/18 15:10:36)
End if 
Case of 
	: ((Form event code:C388=On Mouse Enter:K2:33) | (Form event code:C388=On Mouse Enter:K2:33))
		C_TEXT:C284($Tip_txt)
		$Tip_txt:="First Image (Cmd-PgUp)"
		
		If (<>PL_LPlatfrm=Mac OS:K25:2)
		Else 
			$Tip_txt:=Replace string:C233($Tip_txt; "Cmd"; "CTRL")
		End if 
		
		ut_GenericHelp_OM($Tip_txt)
		
	: (Form event code:C388=On Clicked:K2:4)
		
		FM_SavePhotoInput
		USE NAMED SELECTION:C332("PhotoSet")
		LSS_SelectedRow_L:=1
		LSS_PhotoTraverseRecords
		
End case 