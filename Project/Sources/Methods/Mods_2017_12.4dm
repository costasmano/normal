//%attributes = {"invisible":true}
//Method: Mods_2017_12
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/06/17, 17:40:12
	// ----------------------------------------------------
	//Created : 
	Mods_2017_12
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(12/6/17)
// ActualDataToAssignmnt
//  `adjusted logic to better handle cases where the BDEPT BIN is not properly entered.

//**********`Modified by: Costas Manousakis-(Designer)-(12/6/17)
// Created Method(s) : 

//Method: f_getXMLNode
//Description
// show the name od the node from the SAX get xml Node
// Parameters
// $0 : $Name_txt
// $1 : $Node_L

//**********`Modified by: Costas Manousakis-(Designer)-(12/12/17)
//Method: NTI_ut_UpdateDEFS
//Description
// Update definitions for NTI elements from a spreadsheet saved in xml format supplied by
//J Rigney.

//Modified by: Chuck Miller (12/14/17 16:00:20)
//Change name from LSS_ to ACT_ as it used in more than LSS
//ACT_PushGroupChanges 

//Change name from LSS_ to WIN as it is used ion more than LSS
//Modified by: Chuck Miller (12/14/17 16:00:20)
//WIN_SetWindowTitle


//Modified by: Chuck Miller (12/14/17 16:05:13)
//Add code to include [NTI_ELEM_DEFS] in activity log
//[NTI_ELEM_DEFS];"Input" - New form
//[NTI_ELEM_DEFS];"ListBox_Output" - New form
//NTI_SaveRecord 
//NTI_ListNTI_ElementDefs 
//FM_NTI_Input

//These next changes were do to change in name in lss_pushGroupChanges to ACT_PushGroupChanges
//ut_LSSControlPictureMod 
//NTI_SaveRecord 
//NTI_SaveImage 
//Mods_2017_12 
//LSS_UpdateDMeterorUltraPicture 
//LSS_InspectionRecSave 
//LSS_AccessibilitySave 
//FM_TeamMembersInput 
//FM_SaveVerticalClearance 
//FM_SaveUTResults 
//FM_SaveUT 
//FM_SaveTunnelInfo 
//FM_SaveTowerDistance 
//FM_SaveSignPanel 
//FM_SavePhotoInput 
//FM_SaveInventoryInput 
//FM_SaveElementInspection 
//FM_SaveDMeter
//Compiler_LSS
//COMPILER_Utilities
// Method: Object Method: [LSS_Inventory].Input.Duplicate button
//Method: Object Method: [LSS_Inventory].New_InventoryItem.bValidate
//Method: Object Method: [LSS_refInspectionType].Input.bValidate
//Method: Object Method: [LSS_refRouteDirection].Input.bValidate
//Method: Object Method: [LSS_refStructureCoating].Input.bValidate
//Method: Object Method: [LSS_refStructureMaterial].Input.bValidate
//Method: Object Method: [LSS_refStructureTypes].Input.bValidate
//Method: Object Method: [NTI_TunnelInfo].New_TIN.bValidate


//Next group of changes due to change in name from 
//LSS_SetWindowTitle to WIN_SetWindowTitle
//WIN_SetWindowTitle 
//Mods_2017_12 
//m_ListInspReview 
//LSS_InspReviewLB_OM 
//LSS_CustomSearch 
//Compiler_LSS
//[LSS_Inspection];"InspectionReview" - various buttons and object or form methods
//[LSS_Inventory];"Input"- various buttons and object or form methods
//[LSS_Inventory];"ListBoxOutput"- various buttons and object or form methods
//[NTI_ELEM_DEFS];"ListBox_Output"- various buttons and object or form methods
//[NTI_TunnelInfo];"ListBoxOutput"- various buttons and object or form methods


//Modified by: CostasManousakis (12/20/17)
//Method: NTI_Export_Elem_Defects
//Description
// create export of element and related defects
// Parameters
// $1 : $Defect_elem_tree : DOM with the Element and related defects
// $2 : $Defect_Lang_tree : DOM with the CS language for defects

//Modified by: Chuck Miller (12/21/17 13:13:31)
//Create new table
//TIN_Insp_Comments
//fields are
//INSPID_L
//uuid
//create date iso date time
//created by
//mod date iso date time
//mod by
//comment type string
//comment blob


//Modified by: CostasManousakis (12/26/17)
// ut_CreateMSOfficeDoc
//  `instead of create document use select document with the File name entry option - eventually will allow for a default name to be specified

//End Mods_2017_12