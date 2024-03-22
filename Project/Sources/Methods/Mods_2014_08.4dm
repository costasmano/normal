//%attributes = {"invisible":true}
//Method: Mods_2014_08
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/07/14, 14:01:09
	// ----------------------------------------------------
	//Created : 
	Mods_2014_08
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(8/7/14)
// Modified Method(s) : 
//G_SortTable_new 
//  `Initialize arrays $asFieldNames and $aiFieldNums for each table;
//  `added search to avoid duplicate field names by adding 0 -9 at the end of the field name

// Modified Forms : 
//[ElementsSafety];"TunnelSafetyElmInput" 
//  `fixed label for Rating (was : Above Rating)
//  `Added second page for special member - added object for Special Member Checkbox
//[ElementsSafety];"TunnelSafetySpElmInput"
//  `fixed label for Rating (was : Above Rating)

//**********`Modified by: Costas Manousakis-(Designer)-(8/11/14)
// Modified Forms : 
//[Inspections];"TunnelSpecial"
//  `fixed label for insp date (was 90- routine insp date)

// Modified Method(s) : 
//INSP_ElmSft_Input_FM
//  `Added inspection type TOV to the INSP_IsInspRoutine_b check

//INSP_FCPrPg1_FM
//  `For Tunnel inspections there is no need to move any of the Previous/Current Item ratings

//G_Insp_SetTitle
//INSP_SaveRecords
//  `Added inspection type TOV to the INSP_IsInspRoutine_b check

// Modified Form Methods : 
//Form Method: [Inspections];"InspectionReview"
//  `Added inspection type TOV to the INSP_IsInspRoutine_b check

// Modified Method(s) : 
//SIA_OnDisplayDetail
//  `for Tunnel inspections (page11) Added inspection type TOV to the INSP_IsInspRoutine_b check 

// Modified Object Methods : 
//[Inspections].TunnelInspection.vbPGPreview
//  `set vPageNo=2 befroe printing any spec memb pages. (was viCmtsPgStart-1)

// Modified Method(s) : 
//INSP_PrintSIA 
//  `make sure  [RAILBridgeInfo] record is loaded  ; added NBIS]InspResp="MBTA" check

//**********`Modified by: Costas Manousakis-(Designer)-(8/15/14)
// Created Method(s) : 
//ut_insertTxt2WRblb
//  `Insert a text into a styled text from a 4D Write doc stored in a blob  
//  `main use to add text to comment blobs used in inspection reports. these blobs contain only styled text
// Parameters
// $1 : $Blob_ptr : pointer to the blob with the styled text
// $2 : $Insert_txt : text to insert
// $3 : $InsertPos_L : postion in styled text to insert the new text (measured in characters as returned by WR Count wr nb chars for example)


// Modified Method(s) : 
//COMPILER_Utilities
//  `added ut_insertTxt2WRblb

//**********`Modified by: Costas Manousakis-(Designer)-(8/19/14)
// Created Method(s) : 
//ut_ExportFieldTitles
//  ` export the tables and field titles as defined by SET FIELD titles to xml excel spreadsheets.
//  ` one file per table

// Modified Method(s) : 
//Compiler_SCPOA
//  `added C_TEXT(SCPOA_PrintReportDate_txt)

//**********`Modified by: Costas Manousakis-(Designer)-(8/21/14)
// Modified Forms : 
//[ScourPOA];"FieldVerificationCardpg2"
//[ScourPOA];"Print2-A"
//[ScourPOA];"Print3-A"
//[ScourPOA];"Print4-A"
//[ScourPOA];"Print5-A"
//[ScourPOA];"PrintTemplate" 
//[ScourPOA];"Summary-A"
//[ScourPOA];"Input-A"
//[ScourPOA];"FieldVerificationCardpg1
//  `General POA modifications Aug 2014

// Modified Method(s) : 
//SCPOA_Variables
//SCPOA_Print_A
//Compiler_SCPOA
//  `General POA modifications Aug 2014


//**********`Modified by: Costas Manousakis-(Designer)-(8/22/14)
// Modified Method(s) : 
//Startup
//  `Exclude designer and Administrator from the group checks allowing users to connect

//**********`Modified by: Costas Manousakis-(Designer)-(8/26/14)
// Modified Method(s) : 
//maximo_UpdateMaximo
//  `Added OwnerFilter check
//  `Allow running in default mode or manual mode based on passed parameter
//Compiler_maximo 
//  `Added  maximo_UpdateMaximo 1st paramter

//**********`Modified by: Costas Manousakis-(Designer)-(8/26/14)
// Modified Method(s) : 
//LOGIN_BMSPontisTransfer 
//  `Added at the start maximo_UpdateMaximo

//**********`Modified by: Costas Manousakis-(Designer)-(8/28/14)
// Modified Method(s) : 
//LTR_GenerateTruckPic
//  `for design user allow converting image to another codec.


//```
//```   **** End of Release 6.3.3 08/28/14
//```

//End Mods_2014_08