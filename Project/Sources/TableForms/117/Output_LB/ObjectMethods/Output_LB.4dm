//Method: [PRJ_ProjectFile].Output_LB.Output_LB
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 05/05/22, 16:14:36
	// ----------------------------------------------------
	//Created : 
	Mods_2022_05
End if 
//
If (Form event code:C388=On Load:K2:1)
	LISTBOX SET ROWS HEIGHT:C835(*; "Output_LB"; 2; lk lines:K53:23)
End if 
//End [PRJ_ProjectFile].Output_LB.Output_LB