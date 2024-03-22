//Method: [SQL_Connections].SQL_Connnectsions_LB
//Description
// New form for SQL parameters using Listbox
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Nov 28, 2022, 16:58:04
	Mods_2022_11
	// ----------------------------------------------------
	
End if 
//
C_LONGINT:C283($FormEvent_L)
$FormEvent_L:=Form event code:C388
Case of 
	: ($FormEvent_L=On Load:K2:1)
		UNLOAD RECORD:C212(Current form table:C627->)
		
	: ($FormEvent_L=On Validate:K2:3)
		
End case 

//End [SQL_Connections].SQL_Connnectsions_LB   