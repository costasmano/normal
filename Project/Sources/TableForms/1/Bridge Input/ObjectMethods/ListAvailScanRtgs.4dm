If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(8/20/20 12:51:54)
	Mods_2020_08_bug
	//  `Enable long click on button object and object method to refresh folder seearches.
	//  `Updated Help Tip ListOfSCannedRt 
End if 

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		SFA_GetAvailRatingRpts([Bridge MHD NBIS:1]BDEPT:1; [Bridge MHD NBIS:1]BIN:3)
	: (Form event code:C388=On Long Click:K2:37)
		C_OBJECT:C1216(<>SCRRPT_SavedData_o)
		C_LONGINT:C283($MouseX_L; $mouseY_L; $MouseBtn_L)
		GET MOUSE:C468($MouseX_L; $mouseY_L; $MouseBtn_L)
		OB SET:C1220(<>SCRRPT_SavedData_o; "mouseX"; $MouseX_L)
		OB SET:C1220(<>SCRRPT_SavedData_o; "mouseY"; $mouseY_L)
		CONFIRM:C162("Refresh the Folder search in the SharedData?"; "Refresh"; "Skip")
		OB SET:C1220(<>SCRRPT_SavedData_o; "refresh"; (OK=1))
		SFA_GetAvailRatingRpts([Bridge MHD NBIS:1]BDEPT:1; [Bridge MHD NBIS:1]BIN:3)
		
End case 