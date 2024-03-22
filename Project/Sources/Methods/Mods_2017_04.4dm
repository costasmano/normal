//%attributes = {"invisible":true}
//Method: Mods_2017_04
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/03/17, 17:48:26
	// ----------------------------------------------------
	//Created : 
	Mods_2017_04
	
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(4/3/17)
// Modified Method(s) : 
// ut_OpenBridgeWebSite - v15 only
//  `instead of NET_PING use LEP command for MacOS 

//**********`Modified by: Costas Manousakis-(Designer)-(4/5/17)
// Modified Method(s) : 
// INSP_SetSpMbPrintForm
//  `For MBTA FCR /CMI /OTH inspections check on the bridge type and assign print forms accordingly

//**********`Modified by: Costas Manousakis-(Designer)-(4/18/17)
// Modified Method(s) : 
// INSP_RailRtnPg1_FM
//  `for OVerhead Y/N (variable vOvrHead) search Elements by InspID instead of Selection. 
//  //The selection has been modified by INSP_LoadESForReport

// Form Method: [Inspections];"RoutineSegmentalPg1"
//  `for OVerhead Y/N (variable vOvrHead) search Elements by InspID instead of Selection. 
//  //The selection has been modified by INSP_LoadESForReport

//**********`Modified by: Costas Manousakis-(Designer)-(4/19/17)
// Created Method(s) : 
//Method: Temp_LoadSavedLargePhoto
//Description
// Load a saved Picture variable in the currently loaded Standard photo record.
// Does not save the record!

// Modified Method(s) : 
// Temp_FixStdPhotoSizes
//  `mods to logic and messages

//```
//```   **** End of Release 6.6.4.f 19-Apr-2017
//```

//**********`Modified by: Costas Manousakis-(Designer)-(4/20/17)
// Modified Method(s) : 
// SCPOA_POABtnCtrl
//  `For SCOURPOAEDIT users allow view option if  POA is not their company

// NTI_LoadExportArrays
//  `added declaration of $0;$1 - needed for compiled execution

//**********`Modified by: Costas Manousakis-(Designer)-(4/21/17)
// Modified Method(s) : 
// Shutdown
//  `if the shift key is down and current user is a design user set number of retries to 2 for quicker exit


//**********`Modified by: Costas Manousakis-(Designer)-(4/25/17)
// Modified Method(s) : 
// NTI_XMLScript
// Compiler_NTI 
//  `added NTI_D1_txt   NTI_D2_txt


//Imported changed code for importing pictures form v11
//CNV_ImportPictures
//ut_CNVControlImportPictures 
//ConvertPicture //Form

//End Mods_2017_04