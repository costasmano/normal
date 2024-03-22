//%attributes = {"invisible":true}
//Method: LSS_SetDefDMeterNotes
//Description
// set the Default D Meter notes
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/20/16, 17:21:54
	// ----------------------------------------------------
	//Created : 
	Mods_2016_04_bug
End if 
//
If ([LSS_Inspection:164]LSS_DMeterNotes_txt:50="")
	[LSS_Inspection:164]LSS_DMeterNotes_txt:50:=ut_GetSysParameter("LSS_DMETERSKNOTES")
End if 

//End LSS_SetDefDMeterNotes