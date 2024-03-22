// Method: "MethodsList"
// Description
// Display list of methods using the OneArrayLB form
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 08/29/17, 16:28:05
	// ----------------------------------------------------
	// First Release
	Mods_2017_08
	// Modified by: Costas Manousakis-(Designer)-(10/5/17 15:22:56)
	Mods_2017_10
	//  `on double click check if it starts with the datetime stamp
	//  //added flter by method attributes use v_57_001_atxt field destination from preferences table
End if 
If (False:C215)
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		SET WINDOW TITLE:C213(Get window title:C450+" ("+String:C10(Size of array:C274(LBGeneric_atxt))+")")
		
	: (Form event code:C388=On Double Clicked:K2:5)
		C_TEXT:C284($name_txt)
		C_LONGINT:C283($t_L)
		RESOLVE POINTER:C394(Focus object:C278; $name_txt; $t_L; $t_L)
		If ($name_txt="LBGeneric_ab")
			If (lbGeneric_ab>0)
				C_TEXT:C284($path_txt)
				If (Match regex:C1019("(\\d\\d\\d\\d-\\d\\d-\\d\\dT\\d\\d:\\d\\d:\\d\\d - )"; LBGeneric_atxt{LBGeneric_ab}; 1))
					$path_txt:=Substring:C12(LBGeneric_atxt{LBGeneric_ab}; 23)
				Else 
					$path_txt:=LBGeneric_atxt{LBGeneric_ab}
				End if 
				METHOD OPEN PATH:C1213($path_txt)
				
			End if 
			
		End if 
	: (Form event code:C388=On Validate:K2:3)
		
End case 

//End Form Method: "MethodsList"