//%attributes = {"invisible":true}
//Method: Mods_2019_11_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/01/19, 15:24:17
	// ----------------------------------------------------
	//Created : 
	Mods_2019_11_bug
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(11/1/19)
// G_AddElmtTxt2Area
//  `fixes for CallReference #668
// G_addItemtoWr
//  `fixes for CallReference #668
// G_Insp_AddGenCmts
//  `use G_AddElmtTxt2Area for CallReference #668
// G_Insp_AddOrientation
//  `use G_AddElmtTxt2Area for CallReference #668
// G_Insp_ApplyLineSpacing
//  `adjustments for CallReference #668
// G_InspParagProt
//  `adjustments in the line spacing CallReference #668

//```
//```    **** End of Release 7.2.0.g 01-Nov-2019
//```

//Moved Project retrieve code from development into bug fix 
//and back as there were a few changes made in testing
//Modified by: Chuck Miller (11/5/19 13:28:12)
//ut_TestandCreateFolder 
//ut_PRJRetrieveVendorID 
//ut_PRJRetrieveProjTypes 
//ut_PRJRetrieveProjectFileData 
//ut_PRJRetrieveProjectEvents 
//ut_PRJRetrievePRJxrefs 
//ut_PRJRetrievePRJ_Bridge 
//ut_PRJRetrieveModifiedProjects 
//ut_PRJRetrieveDesignContracts 
//ut_PRJRetrieveDCAmounts 
//ut_PRJRetrieveCPName 
//ut_PRJRetrieveCPAmounts 
//ut_PRJRetrieveConstructionCont 
//ut_PRJRetrieveAttributes 
//ut_PRJRetrieveAEData 
//ut_PRJNewFiscal 
//ut_PRJGetCPAmounts 
//ut_PRJGetAEData 
//ut_PRJCtrlRetrieveProjectData 
//ut_PRJCntrlRetrieveOfAmounts 
//ut_PRJ_CreateFolderPath 
//ut_Import_ExportMethods 
//ut_ArraysToText 
//SQL_Direct

//**********`Modified by: Costas Manousakis-(Designer)-(11/12/19)
//Method: SFA_VerifyMountPoint
//Description
// verify existance of a mount point for shared file access. 
// will return the path to be used in the local machine to access the needed files
// will attempt to mount if mount point not found
// Parameters
// $0 : $TargetPath_txt
// $1 : $BasePath_txt

// SFA_openRatingReport
//  `use method SFA_VerifyMountPoint to verify if the needed share is available.

// SFA_GetAvailRatingRpts
//  `for standalone app try to mount volume using SFA_VerifyMountPoint before searching.

//```
//```    **** End of Release 7.2.0.h 12-Nov-2019
//```


//**********`Modified by: Costas Manousakis-(Designer)-(11/25/19)
// [Inspections];"RailFCRInsppg2"
//  `count of elements changed to 22
// [Inspections];"RailFCRInsppg3"
//  `count of elements changed to 22
// FM_SpecialExtra
//  `Fix labeling of elements to be consistant with page 1 of the reports. 
//  `All page 1 forms use G_GetElmtLabel - CallReference #673

//**********`Modified by: Costas Manousakis-(Designer)-(11/26/19)
// G_InspParagProt
//  `take only last line of element label - CallReference #677

//End Mods_2019_11_bug