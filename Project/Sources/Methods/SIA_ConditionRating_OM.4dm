//%attributes = {"invisible":true}
//Method: SIA_ConditionRating_OM
//Description
// object method for the Condition rating fields on SIA form i58.59.60.61,62
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/23/19, 13:30:08
	// ----------------------------------------------------
	//Created : 
	Mods_2019_01_bug
End if 
//

If (Form event code:C388=On Data Change:K2:15)
	PushChange(1; Self:C308)
	If (INSP_CheckSpcMfrFreq)
		PushChange(1; ->[Bridge MHD NBIS:1]Item92CA:167)
		PushChange(1; ->[Bridge MHD NBIS:1]Item92CB:168)
		PushChange(1; ->[Bridge MHD NBIS:1]Item91:162)
	End if 
End if 

//End SIA_ConditionRating_OM