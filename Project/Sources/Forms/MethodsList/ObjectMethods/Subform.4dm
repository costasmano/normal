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
End case 

//End MethodsList.Subform