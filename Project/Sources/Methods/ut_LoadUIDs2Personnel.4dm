//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/04/05, 11:32:20
	// ----------------------------------------------------
	// Method: ut_LoadUIDs2Personnel
	// Description
	// Load [Personnel]FourDUserID field with User IDs from
	// the 4D password system.
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM18
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
If ((Current user:C182="Designer") | (Current user:C182="Administrator"))
	ARRAY TEXT:C222($arr_UserNames_txt; 0)
	ARRAY LONGINT:C221($arr_UserIDs_L; 0)
	GET USER LIST:C609($arr_UserNames_txt; $arr_UserIDs_L)
	ARRAY BOOLEAN:C223($arr_UserFound_b; Size of array:C274($arr_UserNames_txt))
	C_LONGINT:C283($i)
	For ($i; 1; Size of array:C274($arr_UserFound_b))
		$arr_UserFound_b{$i}:=False:C215
	End for 
	
	ALL RECORDS:C47([Personnel:42])
	C_TEXT:C284($midname_txt; $firstname_txt; $lastname_txt)
	C_LONGINT:C283($arrayLoc)
	
	For ($i; 1; Records in selection:C76([Personnel:42]))
		GOTO SELECTED RECORD:C245([Personnel:42]; $i)
		//Concatenate the names.  
		$firstname_txt:=[Personnel:42]First Name:3+" "+[Personnel:42]Last Name:5
		$arrayLoc:=Find in array:C230($arr_UserNames_txt; $firstname_txt)
		If ($arrayLoc>0)
			If ($arr_UserFound_b{$arrayLoc})
				ALERT:C41("Personnel name "+$firstname_txt+" has already been found")
			Else 
				If (([Personnel:42]Employer:9="Mass.@") | ([Personnel:42]Employer:9="MHD@"))
					$arr_UserFound_b{$arrayLoc}:=True:C214
					[Personnel:42]UserID_4D:12:=$arr_UserIDs_L{$arrayLoc}
					SAVE RECORD:C53([Personnel:42])
					
				Else 
					If ([Personnel:42]Active:11)
						$arr_UserFound_b{$arrayLoc}:=True:C214
						[Personnel:42]UserID_4D:12:=$arr_UserIDs_L{$arrayLoc}
						SAVE RECORD:C53([Personnel:42])
						
					End if 
					
				End if 
				
			End if 
			
		Else 
			[Personnel:42]UserID_4D:12:=0
			SAVE RECORD:C53([Personnel:42])
			
		End if 
		
	End for 
End if 