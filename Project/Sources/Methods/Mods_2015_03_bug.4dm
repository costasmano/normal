//%attributes = {"invisible":true}
//Method: Mods_2015_03_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/04/15, 15:08:36
	// ----------------------------------------------------
	//Created : 
	Mods_2015_03_bug
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(3/4/15)
// Modified Method(s) : 
//SCPOA_Variables
//  `fixed bug where the latest variables  were not stored and retrieved in the correct order
// Modified Forms : 
//[ScourPOA];"FieldVerificationCardpg1"
//  `adjusted location of SCPOA_USGSStProxBrg_s
//[ScourPOA];"Input-A"
//  `removed display format of SCPOA_LowChordDistFt_r to avoid confusion
//  `removed the last text and variables in section 2d, replaced with a two line static text
//[ScourPOA];"Print3-A"
//  `removed the last text and variables in section 2d, replaced with a two line static text
//[ScourPOA];"Summary-A"
//  `adjusted size and location  of checkboxes above Narrative  to show the full text of "recommended chg in insp freq"


//**********`Modified by: Costas Manousakis-(Designer)-(3/16/15)
// Modified Method(s) : 
//PushAllChanges
//  `fix bug in is field number valid statement

//**********`Modified by: Costas Manousakis-(Designer)-(3/18/15)
// Modified Method(s) : 
//Print_CUL_Cmts
//  `fixed bug where  Comments for elements under General for Rail inspections were not printed.

//INSP_ElmSft_Input_FM
//  `Added "GEN" for the vItem variable

//**********`Modified by: Costas Manousakis-(Designer)-(3/19/15)
// Created Method(s) : 
//SCPOA_ImplementTool_OM 
// object method for the tool buttons in the 2 - summary implemented

// Modified Forms : 
//[ScourPOA];"Input-A"
//  ` Added "tool" buttons to clear both checkboxes for the Implemented part in the summary of section 2

//Compiler_SCPOA 
//  `Added variables for tool buttons in section  2 summary / implemented
//  `method SCPOA_ImplementTool_OM


//```
//```   **** End of Release 6.3.3.d 03/20/2015
//```


//End Mods_2015_03_bug