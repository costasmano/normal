//%attributes = {"invisible":true}
//Method: Mods_2019_06_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 06/06/19, 11:25:24
	// ----------------------------------------------------
	//Created : 
	Mods_2019_06_bug
End if 

//**********`Modified by: Costas Manousakis-(Designer)-(6/3/19)
// Modified Method(s) : 
// NTI_DoReviewInspection
//  `Do not mark inspection as Complete when doing DBIE approval (it should already be complete)

// Modified Forms : 
// [Bridge MHD NBIS];"SI & A Input"
//  `disabled automatic drag and drop on item 5 field

//Modified by: Chuck Miller (6/6/19 11:11:44)
//Fix bug where [PRJ_ConstructionProject]CP_Encumbered_r not being filled
//ut_PRJGetCPAmounts - updated in DEV and BF

//**********`Modified by: Costas Manousakis-(Designer)-(6/6/19)
// Created Method(s) : 
//Method: ut_ArraysToText
//Description
// convert arrays to tab delim text
// Parameters
// $0 : $Text_txt
// $1 : pointer to array of pointers

// Method: Test_retrievVWProjectData
// Description
// test to retrieve prooject data from TISH same as "sp_prj_vw_project" call 
// 
// Parameters

//**********`Modified by: Costas Manousakis-(Designer)-(6/14/19)
// Modified Forms : 
// [BridgeMHDNBISArchive];"Rpt Mstr"
//  `Adjusted size and vert location of column labels, TownName and row data
// [Bridge MHD NBIS];"Rpt Mstr"
//  `Adjusted size and vert location of column labels, TownName and row data

//**********`Modified by: Costas Manousakis-(Designer)-(6/26/19)
// G_Insp_SetPersUI
//  `change method of assigning the DBIE field CallReference #639

//Method: INSP_GetDefaultDBIE
//Description
// get the default DBIE ID for a bridge inspection based on Insp resp 
// CallReference #639
// Parameters
// $0 : $DBIE_L
// $1 : $InspResp_txt

//**********`Modified by: Costas Manousakis-(Designer)-(6/27/19)
//Method: ut_FolderListToFile
//Description
// Get a list of files under a selected folder into a text file - does recursive parsing of subfolders
// Parameters

//End Mods_2019_06_bug