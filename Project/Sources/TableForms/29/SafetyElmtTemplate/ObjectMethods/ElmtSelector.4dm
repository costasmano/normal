If (False:C215)
	//Object Method: asElmtSftyPulldwnName 
	Mods_2004_CM12
	Mods_2009_03  //CJM 2004 upgrade   `03/27/09, 12:32:47
	// Modified by: costasmanousakis-(Designer)-(5/15/09 14:17:54)
	Mods_2009_05
	//Check the Read Only state of the table before doing a modify record
	// Modified by: Costas Manousakis-(Designer)-(6/23/21 10:10:45)
	Mods_2021_WP
	//  `
	// Modified by: Costas Manousakis-(Designer)-(9/20/21 09:47:35)
	Mods_2021_09
	//  `fix  for 'flashing' of write areas. just use goto sel record and execute the on Load of the form method and WP area method
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		asElmtSftyPulldwnName:=Find in array:C230(alElmtSftyPulldwnID; [ElementsSafety:29]ElmSafetyID:7)
		
	: (Form event code:C388=On Clicked:K2:4)
		If (alElmtSftyPulldwnID{asElmtSftyPulldwnName}#[ElementsSafety:29]ElmSafetyID:7)
			
			C_TEXT:C284($FormName_txt)
			$FormName_txt:=Current form name:C1298
			
			//WRT_CheckLosingFocus (AreaElmComments;On Losing Focus)
			If (Modified record:C314([ElementsSafety:29]))
				INSP_ElmSft_Input_FM(On Validate:K2:3)
				SAVE RECORD:C53([ElementsSafety:29])
			End if 
			
			GOTO SELECTED RECORD:C245([ElementsSafety:29]; asElmtSftyPulldwnName)
			INSP_ElmSft_Input_FM(On Load:K2:1)
			INSP_Comments_WP_OM(New object:C1471("WPAreaname"; "DE ElementComments_WP"; "fieldptr"; ->[ElementsSafety:29]ElmComments:23; "formEvent"; On Load:K2:1; "changeStack"; 2))
			
		End if 
End case 