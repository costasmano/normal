If (False:C215)
	//Form Method: [zDialogs];"FilesPalette"
	// Modified by: costasmanousakis-(Designer)-(11/1/09 11:38:05)
	Mods_2009_10("MASSDOT")
	//Added text to show that this is By inspection resp.
	// Modified by: Costas Manousakis-(Designer)-(3/23/15 14:02:54)
	Mods_2015_03
	//  `added Ancillary Structures
	// Modified by: Costas Manousakis-(Designer)-(2023-01-12 15:59:01)
	Mods_2023_01_bug
	//  `renamed buttons on form - Added code on Load to enable/disable them 
	//  `in similar way as done for the Enter menu
End if 
C_LONGINT:C283($FormEvent_L)
$FormEvent_L:=Form event code:C388
Case of 
	: ($FormEvent_L=On Load:K2:1)
		C_TEXT:C284($CurrentUser_txt)
		$CurrentUser_txt:=Current user:C182
		If (User in group:C338(Current user:C182; "Design Access Group"))
			ut_TestUser
			$CurrentUser_txt:=<>CurrentUser_Name
		End if 
		//Enable disable buttons using same logic as for the Enter Menu
		If (User in group:C338($CurrentUser_txt; "Access Level 1"))
			//disable all Bridge buttons
			OBJECT SET ENABLED:C1123(*; "Bridge@"; False:C215)
			OBJECT SET ENABLED:C1123(*; "Bridge_Dist1"; User in group:C338($CurrentUser_txt; "District 1"))
			OBJECT SET ENABLED:C1123(*; "Bridge_Dist2"; User in group:C338($CurrentUser_txt; "District 2"))
			OBJECT SET ENABLED:C1123(*; "Bridge_Dist3"; User in group:C338($CurrentUser_txt; "District 3"))
			OBJECT SET ENABLED:C1123(*; "Bridge_Dist4"; User in group:C338($CurrentUser_txt; "District 4"))
			OBJECT SET ENABLED:C1123(*; "Bridge_Dist5"; User in group:C338($CurrentUser_txt; "District 5"))
			OBJECT SET ENABLED:C1123(*; "Bridge_Dist6"; User in group:C338($CurrentUser_txt; "District 6"))
			OBJECT SET ENABLED:C1123(*; "Bridge_DCR"; User in group:C338($CurrentUser_txt; "MDC"))
			OBJECT SET ENABLED:C1123(*; "Bridge_MBTA"; User in group:C338($CurrentUser_txt; "MBTA"))
			
			If (User in group:C338($CurrentUser_txt; "MassPort"))
				//for massport - change title of 'Other Agc' to 'MassPort'
				// in object method check if user is MassPort
				OBJECT SET TITLE:C194(*; "Bridge_Other"; "MassPort")
				OBJECT SET ENABLED:C1123(*; "Bridge_Other"; True:C214)
			End if 
			
			If (User in group:C338($CurrentUser_txt; "DiveGroup"))
				//members of divegroup have access to all bridges
				OBJECT SET ENABLED:C1123(*; "Bridge@"; True:C214)
			End if 
			
		End if   // if "access level 1" user
		
		OBJECT SET ENABLED:C1123(*; "Personnel"; User in group:C338($CurrentUser_txt; "Personnel Admin"))
		
End case 
