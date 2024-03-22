If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(12/2/2005 16:52:57)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(11/19/07 12:43:39)
	Mods_2007_CM_5401
	// Modified by: costasmanousakis-(Designer)-(1/4/09 20:58:26)
	Mods_2009_CM_5404  //Copied to Server on : 03/19/09, 13:57:50  `("WKHRMODS")
	
End if 

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If (User in group:C338(Current user:C182; "ExternalDesigners"))
			If ([Work_Estimate:103]WkHrEstComplete:17)
			Else 
				CONFIRM:C162("Is this Work Hour Proposal Complete?"; "Complete"; "NO")
				[Work_Estimate:103]WkHrEstComplete:17:=(OK=1)
				PushChange(1; ->[Work_Estimate:103]WkHrEstComplete:17)
			End if 
			
		End if 
		C_TEXT:C284($msg; $opt1; $opt2; $opt3)
		C_LONGINT:C283($userChoice)  //Command Replaced was o_C_INTEGER
		If ((Modified record:C314(Current form table:C627->)) | WKHR_SaveRelated_B)
			$msg:="Closing Work Hour Estimate."+Char:C90(13)+"Do you want to save the changes you made to this Proposal?"
			$opt1:="Cancel"
			$opt2:="Don't Save"
			$opt3:="Save"
			$userChoice:=ut_3Option_Confirm($msg; $opt1; $opt2; $opt3)
		Else 
			$userChoice:=2
		End if 
		
		Case of 
			: ($userChoice=1)
				
			: ($userChoice=2)
				CANCEL:C270
			: ($userChoice=3)
				If ([Work_Estimate:103]WkHrEstComplete:17)
					If (([Work_Estimate:103]WkHrEstApproved:18=0) & ([Work_Estimate:103]WkHrEstReviewed:33=0))
						//Save current eng values as original
						WKHR_StoreOrigEngEst("STORE")
					End if 
				End if 
				SET CURSOR:C469(4)
				ACCEPT:C269
		End case 
		
End case 