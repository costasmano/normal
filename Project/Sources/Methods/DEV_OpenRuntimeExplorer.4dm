//%attributes = {"invisible":true}
//Method: DEV_OpenRuntimeExplorer
//Description
// post keys CMD-Shift-F9 / CTRL-Shift-F9 to open runtime explorer
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/25/20, 12:24:51
	// ----------------------------------------------------
	//Created : 
	Mods_2020_08_bug
End if 
//

POST KEY:C465(F9 key:K12:9; (Shift key mask:K16:3+Command key mask:K16:1); 1)

//End DEV_OpenRuntimeExplorer