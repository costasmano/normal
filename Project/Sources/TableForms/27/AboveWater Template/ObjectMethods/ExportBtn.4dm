If (False:C215)
	Mods_2009_03  //CJM 2004 upgrade   `03/27/09, 14:00:59
	// Modified by: Costas Manousakis-(Designer)-(6/23/21 12:20:55)
	Mods_2021_WP
	//  `
	// Modified by: Costas Manousakis-(Designer)-(2021-12-23T00:00:00 13:44:34)
	Mods_2021_12_bug
	//  `call INSP_SaveInspCommts
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		If (Current user:C182="Designer")
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
		End if 
	: (Form event code:C388=On Clicked:K2:4)
		
		//INSP_Check4DWriteChgs 
		INSP_SaveInspCommts
		
		INSP_ExportInspection
End case 
