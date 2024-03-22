//%attributes = {"invisible":true}
//Method: Mods_2019_03_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/22/19, 14:26:42
	// ----------------------------------------------------
	//Created : 
	Mods_2019_03_bug
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(3/13/19)
// Modified Form and Method(s) : 
// [Bridge MHD NBIS];"SI & A Input"
//  `Enabled Page Change at the form properties
//  //at end of on Load and on Page Change make sure no object has focus to avoid inadvertant data entry. CallReference #615
//  `for item 6A and 7 created new entry filter Item6_7 CallReference #617

// Modified Object Methods : 
// [Bridge MHD NBIS];"SI & A Input".Field14
//  `disable entry of and apostrophe and comma. CallReference #618

// Modified Form  : 
// [Bridge MHD NBIS];"BDEPT Input"
//  `for item 6A and 7 created new entry filter Item6_7 CallReference #617

// Temp_ParseText2NBI
//  `give .txt ext to parsed file ; show the parsed file on exit.

//**********`Modified by: Costas Manousakis-(Designer)-(3/14/19)
// [NTI_TunnelInfo];"Input"
//  `use entry filter AlphaNumA for I11 (LRS Route ID)- CallReference #621

//**********`Modified by: Costas Manousakis-(Designer)-(3/15/19)
// PON_ExportFHWANBE
//  `added v_1_006_L to count bridges in the export. update NBEExportXMLHeader_v13.xml and NBEExportXMLClose_v13.xml

// M_SetItem75
//  `use new progress bar

// FN_MilliSec2TimeStr
//  `show less detail depending on the length of time

// InitPers
//  `use "@" when searching for Tunnel Eng and Insp Eng groups

//**********`Modified by: Costas Manousakis-(Designer)-(3/18/19)
// G_Insp_SetPersUI
//  `use NTI_GroupSuffix for the personnel group for DBIE in tunnel inspections
// GRP_GetMembersOfGrps
//  `if the GrpSuffix is "@" , strip the base groupname passed in args 4 when building the name array.
// INSP_AddInspRecs
//  `use NTI_GroupSuffix for the personnel group for DBIE in tunnel inspections

// Modified Forms : 
// [TIN_Inspections];"Input"
//  `changed label of INSP_DIE_atxt to District Tunnel Engr

//**********`Modified by: Costas Manousakis-(Designer)-(3/19/19)
// FM_All_Items_Tunnel_Inspection
//  ` if [TIN_Inspections]WeightPostingNA_B is true set format of posting values so that Zeros show as blank

// [NTI_ELEM_TIN_INSP];"All_Item_Tunnel_Inspection_1"
//  `named posting value fields to WeightPosting_x ; Removed Roof girder , etc. from Rating report data.

//**********`Modified by: Costas Manousakis-(Designer)-(3/20/19)
// INSP_SavePhoto
//  `added Jp2 and emf images types to be prohibited


//**********`Modified by: Costas Manousakis-(Designer)-(3/25/19)
// Modified Form /form Methods : 
// [Cons Inspection];"Cslt Insp In"
//  `enabled on data change event in form events; added code to handle when costs were changed  -CallReference #623
// [Conslt Rating];"Cslt Rating In"
//  `enabled on data change event in form events; added code to handle when costs were changed -CallReference #623

//**********`Modified by: CJMiller-(Designer)-(3/28/19)
// Created Method(s) : 
//Method: ut_ResetPathToServer
//Description
// Reset the path to Server "server_path" in "EnginedServer.4Dlink"
// Modified Method(s) : 
// Startup
//  `call method ut_ResetPathToServer

//End Mods_2019_03_bug