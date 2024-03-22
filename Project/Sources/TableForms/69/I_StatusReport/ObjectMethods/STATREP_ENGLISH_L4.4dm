//Method: Object Method: [Status Report].I_StatusReport.STATREP_ENGLISH_L
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/20/13, 13:56:52
	// ----------------------------------------------------
	//Created : 
	Mods_2013_02
End if 
//
Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		C_BOOLEAN:C305(STATREP_ENGLISH_b)
		If (Self:C308->=0)
			STATREP_ENGLISH_b:=False:C215
		Else 
			STATREP_ENGLISH_b:=True:C214
			
		End if 
		SR_CalculateAreas
		POST OUTSIDE CALL:C329(-1)
End case 

//End Object Method: [Status Report].I_StatusReport.STATREP_ENGLISH_L