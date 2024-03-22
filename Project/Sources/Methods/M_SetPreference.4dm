//%attributes = {"invisible":true}
//GP: Set Preferences
If (False:C215)
	//M_SetPreference 
	// Modified by: Costas Manousakis-(Designer)-(9/2/15 12:20:50)
	Mods_2015_09
	//  `"Preferences" is now project form
End if 

CENTER_WINDOW(400; 250)
DIALOG:C40("Preferences")
CLOSE WINDOW:C154

If (Ok=1)
	Case of 
	End case 
	ALL RECORDS:C47([Preferences:57])
	FIRST RECORD:C50([Preferences:57])
	SAVE RECORD:C53([Preferences:57])
End if 