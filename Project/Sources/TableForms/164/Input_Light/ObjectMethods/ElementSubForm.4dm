//Method: MethodsList.Subform
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/29/17, 16:58:48
	// ----------------------------------------------------
	//Created : 
	Mods_2017_08
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284(1_txt)
		1_txt:="ModDateTime - MethodName"
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Double Clicked:K2:5)
		If (lbGeneric_ab>0)
			C_TEXT:C284($path_txt)
			$path_txt:=Substring:C12(LBGeneric_atxt{LBGeneric_ab}; 23)
			
			METHOD OPEN PATH:C1213($path_txt)
			
		End if 
End case 

//End MethodsList.Subform