//%attributes = {"invisible":true}
//Method: Mods_2017_11_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/01/17, 10:21:33
	// ----------------------------------------------------
	//Created : 
	Mods_2017_11_bug
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(11/1/17)
// NTI_OpenNBEInfo
//  `Corrected resource subfolder to "TIN"

//Modified by: Chuck Miller (11/2/17 
// LSS_CloneFromImport
//Added code to use new progress and to handle uuid fields
// LSS_CloneSetUpSelectInto
//Added code to use new progress and to handle uuid fields
//Same as clone_CloneSetUpSelectInto except we skip UUID fields
// LSS_DeleteImportedRecords
//Added code to use new progress and to handle uuid fields


//**********`Modified by: Costas Manousakis-(Designer)-(11/3/17)
// INSP_ImportInspection
//  `update UUIDs of imported records - skip logging UUID fields
// LogNewRecordChanges
//  `skip uuids
// PushAllChanges
//  `skip UUID fields

//**********`Modified by: Costas Manousakis-(Designer)-(11/8/17)
// [Inspections];"AboveWater Template".DE Button Accept
//  `added On Load and on Unload events to the object 

//Modified by: Chuck Miller (11/13/17 
// clone_CloneSetUpSelectInto
//  `handle case of UUID fields
// clone_ProcessBlobs
//  `use local progress bar if param $2 is -10

//**********`Modified by: Costas Manousakis-(Designer)-(11/17/17)
// ut_ControlUserPrefs
//  ` in the Load task set the debug values to true and 6 only for volume desktop apps

//**********`Modified by: Costas Manousakis-(Designer)-(11/20/17)
// Created Method(s) : 
//Method: NTI_Delete_Image
//Description
// Delete the current [TIN_Insp_Images] image

// [TIN_Insp_Images];"Input".DE bDelete
//  `added method NTI_Delete_Image - set Standard Action of button to "No Action"


//**********`Modified by: Costas Manousakis-(Designer)-(11/28/17)
// NTI_ELEMINP_TIN_FM
//  `added missing InDoubleClick_B:=False at end of On Load event
// NTI_ELEMINP_FM
//  `added missing InDoubleClick_B:=False at end of On Load event

// [Bridge MHD NBIS];"Rating Evalu 10y"
//  `adjusted form objects to fit better on a windows print
//  `use fields from bridge table for SIA data
//  `include the code for i43 and i22 in the description


//End Mods_2017_11_bug