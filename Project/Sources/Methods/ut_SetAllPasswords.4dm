//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/18/11, 16:29:48
	// ----------------------------------------------------
	// Method: ut_SetAllPasswords
	// Description
	// Set all Passwords for all users to delphi - mainly for testing purposes
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_02
End if 

If (User in group:C338(Current user:C182; "Design Access Group"))
	If (Structure file:C489="MHD BMS.@")
	Else 
		ARRAY TEXT:C222($uNames_atxt; 0)
		ARRAY LONGINT:C221($uNumbers_aL; 0)
		GET USER LIST:C609($uNames_atxt; $uNumbers_aL)
		CONFIRM:C162("You are about to change all non-Design passwords to delphi. Are you sure?"; "Sure"; "No")
		If (OK=1)
			CONFIRM:C162("REALLY REALLY SURE??"; "POSITIVE"; "DOUBTS")
			If (OK=1)
				CONFIRM:C162("ABSOLUTELY POSITIVE??"; "FORGET IT"; "ABSOLUTELY")
				If (OK=0)
					C_LONGINT:C283($loop_L; $unum_L; $nblogin_L)
					C_TEXT:C284($uname_txt; $ustart_txt; $oldPw_txt)
					C_DATE:C307($lastLogin_d)
					For ($loop_L; 1; Size of array:C274($uNumbers_aL))
						Case of 
							: (User in group:C338($uNames_atxt{$loop_L}; "Design Access Group"))
							: ($uNames_atxt{$loop_L}="Administrator")
							: ($uNames_atxt{$loop_L}="Designer")
							Else 
								If (Not:C34(Is user deleted:C616($uNumbers_aL{$loop_L})))
									GET USER PROPERTIES:C611($uNumbers_aL{$loop_L}; $uname_txt; $ustart_txt; $oldPw_txt; $nblogin_L; $lastLogin_d)
									$unum_L:=Set user properties:C612($uNumbers_aL{$loop_L}; $uname_txt; $ustart_txt; "delphi"; $nblogin_L; $lastLogin_d)
								End if 
								
						End case 
						
					End for 
					ALERT:C41("Changed all passwords to delphi")
				End if 
				
			End if 
			
		End if 
		
	End if 
	
End if 