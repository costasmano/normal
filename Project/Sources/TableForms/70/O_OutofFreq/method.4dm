If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/05/10, 14:16:06
	// ----------------------------------------------------
	// Method: Form Method: O_OutofFreq
	// Description
	// Added to control acces to the list
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_03
	//  `Added code to control entry /deletion buttons depending on whether user ahs read write access
End if 
Case of 
	: ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Close Detail:K2:24))
		C_TEXT:C284($currentUser_txt)
		$currentUser_txt:=Current user:C182
		If (User in group:C338($currentUser_txt; "ReadWrite"))
			
			OBJECT SET ENABLED:C1123(bzAdd; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(bzDelete; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET VISIBLE:C603(bzDelete; True:C214)
			OBJECT SET VISIBLE:C603(bzAdd; True:C214)
			OBJECT SET VISIBLE:C603(*; "DeleteButton"; True:C214)
		Else 
			OBJECT SET ENABLED:C1123(bzAdd; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(bzDelete; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET VISIBLE:C603(bzDelete; False:C215)
			OBJECT SET VISIBLE:C603(bzAdd; False:C215)
		End if 
		
End case 