//Method: MethodsList.CMDOButton
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2022-05-05T00:00:00, 18:02:04
	// ----------------------------------------------------
	//Created : 
	Mods_2022_05
End if 
//
If (lbGeneric_ab>0)
	If (LBGeneric_ab{LBGeneric_ab})
		C_TEXT:C284($path_txt)
		If (Match regex:C1019("(\\d\\d\\d\\d-\\d\\d-\\d\\dT\\d\\d:\\d\\d:\\d\\d - )"; LBGeneric_atxt{LBGeneric_ab}; 1))
			$path_txt:=Substring:C12(LBGeneric_atxt{LBGeneric_ab}; 23)
		Else 
			$path_txt:=LBGeneric_atxt{LBGeneric_ab}
		End if 
		METHOD OPEN PATH:C1213($path_txt)
		
	End if 
	
End if 

//End MethodsList.CMDOButton