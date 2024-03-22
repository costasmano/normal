//%attributes = {"invisible":true}
//Method: Mods_2013_05
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/01/13, 08:24:27
	// ----------------------------------------------------
	//Created : 
	Mods_2013_05
End if 
//
//Adjusted heading on tunnel reports
//[Inspections];"TunnelReprtTemplate"
//[Inspections];"TunnelOverPg1"
//[Inspections];"TunnelRoutinePg1"
//[Inspections];"TunnelSpecialMember"
//Created tunnel spec member input form
//[Inspections];"TunnelSpecial"


//Changed to local arrays
//Compiler_Arrays 
//ut_CompareStoredTOWNData
//ut_CompareStoredBlobData 
//ut_CompareStoredPersData 
//ut_CompareStoredBMSArrays 

//Add Compiler_NewInspReports so it is only called once at process launch
//InitProcessVar 

//Change [Element Cat]Description to 20 characters from 15
//INIT_FIELDS_ARRAYS 
//SRC_EL_Util 
//INSP_LoadaInspType_ 

//Add tunnel inspection types
//PRINT_Critical
//Print_Dive_Cmt_a_new 
//Print_SpecMem_pg1
//G_CountSpMbPgs 
//INSP_FCPrPg1_FM 
//INSP_ElmtSfty_ItemNo
//INSP_ReturnCMLength 
//G_CountRTNInspPgs
//PRINT_TunnelAllItems_F
//INSP_ReturnCMLength 

//New code for import and export of
//[Inspection Type]
//[Element Cat]
//[ElementDict]
//[TableOfLists]
//New form ("Testing")

//utl_ExportInpectionTypes 
//utl_ImportNewInspectionTypes 
//
//utl_ExportElementDictionary 
//utl_ImportElementDictinary 
//
//utl_ExportTOLRecords
//utl_ImportTOLRecords 
//
//utl_ExportElementCat
//utl_ImportElementCat 
//
//Compiler_ForUtilityExport 

//```
//```   **** End of Release 6.2.0 5/29/13
//```

//**********`Modified by: Costas Manousakis-(Designer)-(5/29/13)
// Modified Object Methods : 
//[Bridge MHD NBIS];"Bridge Input".bOpenInsp
//  `Replaced ut_Read_Write_Tables with  INSP_Read_Write_Tables ("WRITE") to make sure all needed tables are set to Write

//**********`Modified by: Costas Manousakis-(Designer)-(5/30/13)

// Modified Method(s) : 
//INSP_MyReviewInspections
//  `moved the code for getting MYINSPECTIONS at the end of CLEANUP block

// Modified Forms : 
//[Bridge MHD NBIS];"Bridge Input"
//  `Renamed all highlite sets of the listboxes to be different for each listbox
// Modified Object Methods : 
//[Bridge MHD NBIS];"Bridge Input".bDuplicate
//[Bridge MHD NBIS];"Bridge Input".bOpenInsp
//[Bridge MHD NBIS];"Bridge Input".ChgInspTypeBtn
//  `Set name of listbox changed to LBSetBrgInsp
//  `Set name of listbox changed to LBSetTunnelInsp for Tunnels

// Modified Method(s) : 
//SIA_ControlDoubleClick
//INSP_PrintInspBtn_OM
//INSP_PrintQAForm_OM
//  `Set name of listbox changed to LBSetBrgInsp for bridge inspections, LBSetTunnelInsp for Tunnel inspections

// Created Method(s) : 
//ut_SynchFromProdForPreservation
//  ` Sync tables from production server to current db for the Preservation module
//  ` Uses db parameters PresProdIP and PresTablesToSynch


//**********`Modified by: Costas Manousakis-(Designer)-(5/31/13)
// Created Method(s) : 
//Compiler_SIA 
//  `Added array text(SIA_Tabs_atxt;0)

// Modified Form Method(s) : 
//[Inspections];"InspectionReview"
//  `Added Redraw Window at end of on Close Detail

//End Mods_2013_05