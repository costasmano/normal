// ----------------------------------------------------
//User name (OS): Costas Manousakis
//User (4D) : Designer
//Date and time: 01/12/12, 18:00:48
// ----------------------------------------------------
//Method: Form Method: [ScourPOA]Print1-A
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//Created : 
	Mods_2012_02
	// Modified by: Costas Manousakis-(Designer)-(3/13/12 09:58:17)
	Mods_2012_03
	//  `Changed checkboxes to resource file "checkbox.png"
	// Modified by: Costas Manousakis-(Designer)-(3/23/12 16:28:14)
	Mods_2012_03
	//  `adjusted size and location of pictures and pict labels ; fixed NAVD - NGVD29 conversion text
	// Modified by: Costas Manousakis-(Designer)-(5/10/12 09:07:28)
	Mods_2012_05
	//  `Fixed labeling of 1g. object names
	// Modified by: Costas Manousakis-(Designer)-(8/14/12 11:01:04)
	Mods_2012_08
	//  `Fixed SCPOA_SourceOther_L_P check box - was not the right variable
	// Modified by: Costas Manousakis-(Designer)-(3/14/13 17:16:43)
	Mods_2013_03
	//  `Added var for checkbox SCPOA_SourceRefList_L  : not _P becauce it gets calculated only at print time
	
End if 
//
SCPOA_PrintPG1_FM
//End Form Method: [ScourPOA]Print1-A