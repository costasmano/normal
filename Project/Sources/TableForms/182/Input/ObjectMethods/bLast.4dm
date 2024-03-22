//Method: [NTI_ELEM_DEFS].Input.bLast
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/14/17, 17:04:47
	// ----------------------------------------------------
	//Created : 
	Mods_2017_12
End if 
//
LBRow_L:=Records in selection:C76([NTI_ELEM_DEFS:182])

NTI_SaveRecord

GOTO SELECTED RECORD:C245([NTI_ELEM_DEFS:182]; LBRow_L)

FM_NTI_Input(On Load:K2:1)

//End [NTI_ELEM_DEFS].Input.bLast