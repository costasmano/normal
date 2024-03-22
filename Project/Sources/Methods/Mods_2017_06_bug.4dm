//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 06/21/17, 15:22:09
//----------------------------------------------------
//Method: Mods_2017_06_bug_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2017_06_bug
	//Modified by: Chuck Miller (6/21/17 15:22:11)
	
End if 
//Fix error where errors occur and tranaction not cancelled
//ut_LSSControlPictureMod 
//ut_ImportUpdatedPictures 
//LSS_UpdateDMeterorUltraPicture 
//LSS_TempFixSignInspections 
//LSS_SetSaveandDelete 
//LSS_SaveDMorUTPicture 
//LSS_ResequencePictures 
//LSS_LoadElementInspectionRecord 
//LSS_InspectionRecSave 
//LSS_ErrorMethod 
//LSS_EditTeam 
//LSS_EditDMeterSketchNotes 
//LSS_DeletePhoto 
//LSS_CreatePhotoRecord 
//LSS_AddVerticalClearanceRecord 
//LSS_AddUTResultRecord 
//LSS_AddTowerDistanceRecord 
//LSS_AddSignPanelRecord 
//LSS_AddDMeterRecord 
//FM_SaveUT 
//FM_SaveTowerDistance 
//FM_SaveSignPanel 
//FM_SavePhotoInput 
//FM_SaveInventoryInput 
//FM_SaveDMeter 
//FM_InspectionInput 
//FM_Accessibility 
//Compiler_LSS
//Method: Object Method: [LSS_Inspection].Inspection_Template.bDelete
//Method: Object Method: [LSS_Inspection].Inspection_Template.bValidate
// Method: Object Method: [LSS_Inspection].Input_ITS.bCancel
//Method: Object Method: [LSS_Inspection].Inspection_Template.bValidate
//Method: Object Method: [LSS_Inventory].New_InventoryItem.bValidate
//LSS_UpdDmeterPhotoDescription
//Add additional cancel so input form closes and second error message not displayed
//LSS_ControlModification 
//FM_SaveVerticalClearance 
//FM_SavePhotoInput 
//FM_SaveInspection 
//FM_SaveDMeter 
//FM_InspectionInput
//Method: Form Method: [LSS_Inventory]New_InventoryItem
//Method: Object Method: [LSS_Inventory].New_InventoryItem.bValidate




// Modified Method(s) : 
// InitChangeStack
//  `insert in array the difference between the level requested to the current size of the ptr_changes array
//  `also initialize ptr_changes if it is not

// Modified Forms : 
// [zDialogs].EasySearch
//  `combined the two previous scrollable arrays asFields and asFldTypes into one listbox.
//  `they were converted into separate listboxes in conversion.
//  `changed font to Label12Plain

// PON_LoadElementHelp
//  `for application versions other than 11 use the v13 version of the template.

// [LSS_DMeter];"Input".bFirst
//  `fixed missing case statement for load and clicked events


// [Inspections];"Closed Insp Pg1".vTeamMbr
//  `in v15 array is a text array
// [Inspections];"FrzThawPg1".vTeamMbr
//  `in v15 array is a text array
// [Inspections];"FrzThawPg1A".vTeamMbr
//  `in v15 array is a text array

// WRUTIL_Function
//  `for ZOOM function store the selected factor index in a process variable - use REDRAW WINDOW to update the view
//  //for CLEANCHARS don't mark any more the bad characters - try to fix some the rest leave as is.

// [LSS_Inventory];"ListBoxOutput".Inventory_LB
//  `Keep track of doubleclick event so that multiple double-clicks do not get processed before the first double click is done through

// FlushGrpDeletions
//  `arr_DeletedIDs can be text array
// PushGrpDelete
//  `arr_DeletedIDs can be text array
// [Bridge MHD NBIS];"SI & A (Insp)"
//  `<>aFreezeThawDesc can be a text array
// [Bridge MHD NBIS].TunnelSIA
//  `<>aFreezeThawDesc can be a text array
// [BridgeMHDNBISArchive].SI & A (Insp)
//  `<>aFreezeThawDesc can be a text array
// InitProcessVar
//  `<>aFreezeThawDesc can be a text array - also no need to merge code and descr for freeze thaw drop down


//```
//```   **** End of Release 7.0.0.c 06/27/2017
//```

// Modified Method(s) : 
// SFA_GetBridgeFolder
//  `added wildcard at the end when searching for BDEPT-BIN folder name

//End Mods_2017_06_bug

