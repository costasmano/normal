//Method: [NTI_ELEM_DEFS].Input.bPrevious
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/14/17, 16:47:43
	// ----------------------------------------------------
	//Created : 
	Mods_2017_12
End if 
//
LBRow_L:=LBRow_L-1

NTI_SaveRecord
GOTO SELECTED RECORD:C245([NTI_ELEM_DEFS:182]; LBRow_L)

FM_NTI_Input(On Load:K2:1)

//End [NTI_ELEM_DEFS].Input.bPrevious