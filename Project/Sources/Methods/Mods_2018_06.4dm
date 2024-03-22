//%attributes = {"invisible":true}
//Method: Mods_2018_06
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/04/18, 12:47:30
	// ----------------------------------------------------
	//Created : 
	Mods_2018_06
End if 
//
//Move code from Mods_2018_06_Bug
//Make changes to [LSS_Photos] input to try and fix problems with blank [Activity Log] records

//[LSS_Photos];"Input"
//LSS_PhotoTraverseRecords 
//FM_SavePhotoInput 
//FM_PhotoInput 


// Shutdown
//  `cleaned up old unused code

//Add new Column (TIN) and allow for sort on [NTI_TunnelInfo];"ListBoxOutput"
//Modified by: Chuck Miller (6/5/18 16:50:23)
//Method: NTI_SortByFormula
//Method: Object Method: [NTI_TunnelInfo];"ListBoxOutput".SelectListBox


//**********`Modified by: Costas Manousakis-(Designer)-(6/9/18)
// InitProcessVar
//  `Added SET DATABASE PARAMETER(49;2) to allow searching by fields in other tables.

//Made changes to Incomplete Inspection Report
//Server_ReportIncompleteInsp

//Following methdods are new
//Made changes to clone utility to allow for missing fields in the remote. For now all that code is commented out
//The next methdos will report on all fields or just the missing ones
//clone_ReportMissingFields
//Thois methd creates array of missing fields
//clone_CreateremoteMissingFields 
//APPEND TO ARRAY(clone_MissRemoteTableFld_atxt;Table name($TableNumber_L)+"--"+Field name($TableNumber_L;$loop_L))
//This method will resize missing arrays to the proper size based upon retrieve so that array to selection will work.
//clone_ResizeMissingArrays

//Begin changes clone_ControlClone
//Following methods are modified (mods are now commented out)
//Uncomment out   //clone_CreateremoteMissingFields in 
//clone_ControlClone 
//End changes clone_ControlClone

//Begin changes clone_Table
//Uncomment out line 360 if no more changes made
//If (Size of array(Clone_FirstArray_ptr->)>0)
//clone_ResizeMissingArrays (Size of array(Clone_FirstArray_ptr->))
//End if 
//in clone_Table

//Begin changes clone_CloneSetUpSelectInto
//Uncomment out 
//Line 71
//ARRAY TEXT(clone_MissingArrayNames_atxt;0)
//CLEAR VARIABLE(Clone_FirstArray_ptr)
//C_BOOLEAN($setPointer_B)
//$setPointer_B:=True

//Line 81
//$TableNameFieldCombo_txt:=Table name($TableNumber_l)+"--"+Field name($TableNumber_l;$Loop_l)
//$FindInMissingArray_L:=Find in array(clone_MissRemoteTableFld_atxt;$TableNameFieldCombo_txt)
//Line 103
// & ($FindInMissingArray_L<1)
//If ($setPointer_B)
//Clone_FirstArray_ptr:=Get pointer($BindToVariable_txt)
//$setPointer_B:=False
//End if 

//Line 122
//APPEND TO ARRAY(clone_MissingArrayNames_atxt;$BindToVariable_txt)
//End changes  clone_CloneSetUpSelectInto

// Modified Method(s) : 
// Method: SQL_CloneInspectionRelated
// Method: sql_CloneRemoveElement


//Make sure sort is correct on Tunnel Info list
//[NTI_TunnelInfo];"ListBoxOutput"
//Method: Object Method: [NTI_TunnelInfo].ListBoxOutput.bAdd
//Method: Object Method: [NTI_TunnelInfo].ListBoxOutput.bShowAll
//Method: Object Method: [NTI_TunnelInfo].ListBoxOutput.bShowSubset  
//Method: Object Method: [NTI_TunnelInfo].ListBoxOutput.bQuery
//Method: Object Method: [NTI_TunnelInfo];"ListBoxOutput".SelectListBox

// Modified Method(s) : 
// m_DisplayTINs
//Add new Column (TIN) and allow for sort on [NTI_TunnelInfo];"ListBoxOutput"


//Add TIN to list
//[TIN_Inspections];"ReviewList"

// Modified Method(s) : 
// NTI_ControlModification
//  `get the table name from the table ptr


//**********`Modified by: Costas Manousakis-(Designer)-(6/18/18)
// [Inspections];"AboveWater Template"
//  `replaced background offset buttons 2 4 state buttons in resources
// [Bridge MHD NBIS];"BridgeTemplate"
//  `replaced 3D background offset Buttons with 4 state from resources

// Created Method(s) : 
//Method: Dev_convertLibPicToPNG
//Description
// convert a libary picture into a png 4 state button

//**********`-(6/19/18)
//Method: ut_LoadFormsandGetInfo
//Description
// report on form content

//Method: ut_FormGetObjects
//Description
// get form objects

//**********`Modified by: Costas Manousakis-(Designer)-(6/20/18)
// [Bridge MHD NBIS];"ID Input"
//  `name of first tab to MADOT

// PON_ELEMINP_FM
//  `disable the delete button for new element.
// NTI_ELEMINP_TIN_FM
//  `disable the delete button for new element.
// NTI_ELEMINP_FM
//  `disable the delete button for new element.

//```
//```    **** End of Release 7.1.1 20-June-2018
//```


//Modified by: Chuck Miller (6/28/18 16:52:38)
//Add new fields to lss tables to handle damage reports
//[LSS_Inspection]LSS_Damage_d
//[LSS_Inspection]LSS_DamageAccidentReport_B
//[LSS_Inspection]LSS_DamageBy_s
//[LSS_Inspection]LSS_DamagereimbursementNo_s

//[LSS_ElementInspection]LSS_DamageCrack_B
//[LSS_ElementInspection]LSS_DamageCurrentCondition_s
//[LSS_ElementInspection]LSS_DamagePreviousCondition_s
//[LSS_ElementInspection]LSS_DamageWeldCondition_s
//[LSS_ElementInspection];"Input"
//FM_ElementInspection
//End Mods_2018_06