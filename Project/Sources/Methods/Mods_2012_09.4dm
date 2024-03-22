//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 09/04/12, 14:32:18
//----------------------------------------------------
//Method: Mods_2012_09
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_09  //r001 ` 
	//Modified by: Charles Miller (9/4/12 14:32:19)
	
End if 

//Modified by: Charles Miller (9/4/12 14:32:19)
//Add code and dropdowns to [BridgeMHDNBISArchive] output form to allow for query by ArchiveReason ,Date

//**********`Modified by: Costas Manousakis-(Designer)-(9/10/12)
// Modified Object Methods : 
//[BridgeMHDNBISArchive].Output.ARCH_TOOL_BTN_L 
//  `Added query by formula and query selection by formula

// Modified Method(s) : 
//QR_Item43A
//  `Added optional parameter

// Created Method(s) : 
//ut_defineBrgCondRtg
//  `Create the DOM tree holding the range of bridge cond and corresponting Text value.
//  `Store the tree in parameters table 

//QR_Archive_LTE4NextYr
//  ` Return Whether the archive record from next year has rtgs lte 4
// Parameters
// $0 : $SDNextYear_L (0 : not ; 1 : Yes ; -1 : some error
// $1 : $ARCHIVEREAson_txt (optional - if non-blank passed must pass $2 $3)
// $2 : $archiveDate_txt  (optional)
// $3 : $BIN_txt (optional)
// $4 : $YearDiff_L (optional)

//QR_Archive_GetOwner
//  ` return ITEm 8 Owner from an archive reoord
// Parameters
// $0 : $Owner_txt
// $1 : $BIN_txt
// $2 : $Reason_txt
// $3 : $ArchDate_d

//QR_Archive_BrgAge
//  ` The bridge age of an archive reord at time of archival
// Parameters
//$0 : Age (integer)
//$1: [Year Built (Integer)]
//$2: [Year ReConstructed] (integer)

//QR_Archive_NextYear_Fld
//  ` In progress 
//QR_Appraisal_LTE4_L
//  ` If any of the ratings are lte 4
// Parameters
// $0 : $LTE4_L (0 : not ; 1 : Yes ; -1 : some error)
// $1 : $i58_txt
// $2 : $i59_txt
// $3 : $i60_txt
// $4 : $i62_txt

//QR_BridgeCondCategory
//  ` The bridge condition category based on a value
// Parameters
// Parameters
// $0 : $Category_txt
// $1 : $CondValue_r

//QR_LegacyOwner
// Legacy Owner 
// Parameters
// $0 ; $Owner_txt
// $1 : $LegacyOwner_txt
// $2 : $CurrentOwner_txt

//QR_Archive_AvgBridgeCond
//  `return the average bridge condition ; -1 if an error or invalid values
// Parameters
// $0 : (real)
// $1 : $reason_txt
// $2 : $reasonDate_txt
// $3 : $Bin_txt

//QR_AvgBridgeCondCategory
//  ` the bridge condition category based ◊BRG_CONDRANGE_aR
// Parameters
// $0 : $Category_txt
// $1 : $item58
// $2 : $item59
// $3 : $item60
// $4 : $item62

//QR_Archive_SDNextYear
//  `Check whether next year record is LTE 4
// Parameters
// $0 : $SDNextYear_L (0 : not ; 1 : Yes ; -1 : some error
// $1 : $ARCHIVEREAson_txt
// $2 : $archiveDate_txt
// $3 : $BIN_txt
// $4 : $YearDiff_L

//QR_CurrBridgeOwner
//  ` Current owner of a BIN Item 8 Owner
// Parameters
// $0 : $Owner_txt  : owner code
// $1 : $BIN_txt

//QR_Archive_RebltOrRem_NxtYr
//  ` Whether a record was rebuilt next year or removed
// Parameters
// $0 : $SDNextYear_L
// $1 : $ARCHIVEREAson_txt
// $2 : $archiveDate_txt
// $3 : $BIN_txt
// $4 : $YearDiff_L

//fn_BridgeCondCategory
//  ` The bridge cond category based on ◊BRG_CONDRANGE_atxt
// Parameters
// $0 : $Category_txt
// $1 : $avg_r


//COMPILER_QRMethods 
//COMPILER_Utilities 
//COMPILER_Archive
//  `Compiler methods to hold declarations for QR methods, Utility methods, Archive ui

// Modified Method(s) : 
//INIT_UI_GV 
//  `Added call to ut_defineBrgCondRtg

// Created Method(s) : 
//QR_I43A_MajorGroups
//  ` Split the material from Item43a to major groups
// Parameters
// $0 : $MatGroup_txt
// $1 : $MaterialCode_txt (will use the 1st char)

// Created Method(s) : 
//fn_ReturnName
// Returns the name of a person from a pointer to a variable containing the id of the person from the [Personnel] table

//  ` *** Used fn_ReturnName in all object methods for vDBIE in inspectioin print forms

// Modified Method(s) : 
//PRINT_ROUTINE_F
//  `r001 `Add compiler method Compiler_InspReports
//  `Modified by: Charles Miller (9/13/12 15:15:56)
//  `moved 2nd G_PrintOptions call after the 2nd  If (OK=1)  `user can cancel from the print settings  

//Set Doc Margins
//  `increased wr paper width  from 7.4 to 7.5 ; and wr text right margin from 0 to 0.1 to prevent cutting off letters.

//G_InitInspVars
//  ``added c_string(40;vDBIE )

//ut_SRVMonthlyReports
//  `r001 `Add code to check for missing document. If all found no email sent 

//End Mods_2012_09