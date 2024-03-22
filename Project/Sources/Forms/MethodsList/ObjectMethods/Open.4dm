//Method: MethodsList.Button1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/29/17, 15:45:07
	// ----------------------------------------------------
	//Created : 
	Mods_2017_08
End if 
//

If (LBGeneric_ab>0)
	C_LONGINT:C283($OpenCount_L)
	C_LONGINT:C283($loop_L)
	$OpenCount_L:=0
	C_TEXT:C284($path_txt)
	
	For ($loop_L; 1; Size of array:C274(LBGeneric_ab))
		If (LBGeneric_ab{$loop_L})
			$OpenCount_L:=$OpenCount_L+1
		End if 
	End for 
	
	Case of 
		: ($OpenCount_L=0)
			
		: ($OpenCount_L=1)
			$path_txt:=Substring:C12(LBGeneric_atxt{LBGeneric_ab}; 23)
			
			METHOD OPEN PATH:C1213($path_txt)
		: ($OpenCount_L<10)
			For ($loop_L; 1; Size of array:C274(LBGeneric_ab))
				If (LBGeneric_ab{$loop_L})
					$path_txt:=Substring:C12(LBGeneric_atxt{$loop_L}; 23)
					METHOD OPEN PATH:C1213($path_txt)
					
				End if 
			End for 
		Else 
			CONFIRM:C162("There are "+String:C10($OpenCount_L)+" methods selected!!! are you sure you want to open all of them?")
			If (OK=1)
				For ($loop_L; 1; Size of array:C274(LBGeneric_ab))
					If (LBGeneric_ab{$loop_L})
						$path_txt:=Substring:C12(LBGeneric_atxt{$loop_L}; 23)
						METHOD OPEN PATH:C1213($path_txt)
						
					End if 
				End for 
			End if 
	End case 
	
	
End if 

//End MethodsList.Button1