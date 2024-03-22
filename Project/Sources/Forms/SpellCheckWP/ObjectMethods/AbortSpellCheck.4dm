//Method: "SpellCheckWP".AbortSpellCheck
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2022-03-17, 11:47:17
	// ----------------------------------------------------
	//Created : 
	Mods_2022_03
End if 
//
C_OBJECT:C1216(SpellCheckAllData_o)

SpellCheckAllData_o.abortspell:=True:C214
//now cancel out of form
CANCEL:C270

//End  "SpellCheckWP".AbortSpellCheck