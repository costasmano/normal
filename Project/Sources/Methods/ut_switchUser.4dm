//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/18/11, 16:30:54
	// ----------------------------------------------------
	// Method: Method: ut_switchUser
	// Description
	// change user
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_02
	Mods_2011_06  // CJ Miller`06/20/11, 10:32:48      ` Type all local variables for v11
End if 
If (User in group:C338(Current user:C182; "Design Access Group"))
	ARRAY TEXT:C222($uNames_atxt; 0)
	ARRAY LONGINT:C221($uNumbers_aL; 0)
	C_LONGINT:C283($User_L)
	GET USER LIST:C609($uNames_atxt; $uNumbers_aL)
	SORT ARRAY:C229($uNames_atxt; $uNumbers_aL)
	$User_L:=G_PickFromList(->$uNames_atxt)
	C_TEXT:C284($PW_txt)
	If ($User_L>0)
		If (Is user deleted:C616($uNumbers_aL{$User_L}))
		Else 
			$PW_txt:=Request:C163("Enter password for "+$uNames_atxt{$User_L})
			If (OK=1)
				CHANGE CURRENT USER:C289($uNames_atxt{$User_L}; $PW_txt)
				If (OK=0)
					ALERT:C41("Incorrect password for "+$uNames_atxt{$User_L})
				Else 
					ALERT:C41("Changed to "+Current user:C182)
				End if 
				
			End if 
			
			
		End if 
	End if 
End if 