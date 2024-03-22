//Method: "TaskList"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 08/27/20, 15:24:20
	// ----------------------------------------------------
	//Created : 
	Mods_2020_08
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		TL_FillArrays
		
		SET TIMER:C645(1200)
		
	: (Form event code:C388=On Timer:K2:25)
		TL_FillArrays
		
		
		SET TIMER:C645(1200)
		
		
End case 
//End TaskList