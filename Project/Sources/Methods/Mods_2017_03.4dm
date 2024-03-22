//%attributes = {"invisible":true}
//Method: Mods_2017_03
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/01/17, 12:04:00
	// ----------------------------------------------------
	//Created : 
	Mods_2017_03
End if 

//
//**********`Modified by: Costas Manousakis-(Designer)-(3/1/17)
// Modified Method(s) : 
// INIT_UI_GV
//  `added global vars to indicate  MetricTon or RatingFactor for item 63,65
// SET_Item70
//  `use ◊SIA_LoadRtg_63_RF_txt to decide if  item 64 is rating factor or MT
// ExportNBI
//  `use new global var ◊SIA_LoadRtg_63_RF_txt
// G_FormatItm6466
//  `use new global vars for MT or RF  rating loads
// SQL_sp_Update_NBI_Data
//  `use ◊SIA_LoadRtg_63_RF_txt for the rating loads 64 and 66
// LoadNBIData
//  `use  new global var ◊SIA_LoadRtg_63_RF_txt for load ratings 64 and 66
// Compiler_SIA
//  `added global vars to indicate  MetricTon or RatingFactor for item 63,65
// ImportFEDrecord_old
//  `use  new global var ◊SIA_LoadRtg_63_RF_txt for load ratings 64 and 66
// SET_Item75
//  `use ◊SIA_LoadRtg_63_RF_txt to decide if  InvRating is rating factor or MT and convert item66 to MT if RF
// AASHTO_SuffRat
//  `use ◊SIA_LoadRtg_63_RF_txt to decide if  InvRating is rating factor or MT
// Temp_ParseText2NBI
//  `use ◊SIA_LoadRtg_63_RF_txt to decide if  Load Rating s 64,66  are rating factor or MT
// ARCHIVE_RecalcAASHTO
//  `use ◊SIA_LoadRtg_63_RF_txt to decide if  item 64 is rating factor or MT

// ut_ImportFHWADataToArchive
// ARCHIVE_ExportNBI
// ARCHIVE_ExportNBItabDelim
//  `use ◊SIA_LoadRtg_63_RF_txt to decide if  item 64 is rating factor or MT

//**********`Modified by: Costas Manousakis-(Designer)-(3/2/17)
// Created Method(s) : 
//Method: Make4StateButton
//Description
// make a 4 state button from a picture
// Parameters
// $0 : Result_pic
// $1 : Input_pic

//**********`Modified by: Costas Manousakis-(Designer)-(3/3/17)
// ut_SaveServerProcessRecords
//  `Use variable ◊DatabaseStructureName_txt defined at beginning of on server startup
// ut_LoadServerProcessRecords
//  `Use variable ◊DatabaseStructureName_txt defined at beginning of on server startup

// Created Method(s) : 
// ExportNBI_test
// Description
//  ` copied from ExportNBI to export all records making sure that the record is correct length
//  ` Still run our checks and log to the error file
// ExportNBI
//  `at the end ask Designe user to run the testExport where all  NBI records are  written to MFINPUT.TXT regardless of "missing" data

//**********`Modified by: Costas Manousakis-(Designer)-(3/6/17)
// Modified Method(s) : 
// P_ReviewLogged
// P_ReviewChanges
//  `added sorting by RefID

// Modified Table(s) : 
//[RAILBridgeInfo]
//  `Added fields [RAILBridgeInfo]Rating_HSP46 (R) [RAILBridgeInfo]Rating_HSP46_Max (R)  RAILBridgeInfo]Rating_HSP46_fatigue_r (R)

//[ElmtRatingLoads]
//  `renamed field [ElmtRatingLoads]Dummy_s  to [ElmtRatingLoads]R_HSP46_r and made visible

// Modified Method(s) : 
// INSP_LoadElmRtgDefs
//  `added vHSP46_ in the arrays  linked to [ElmtRatingLoads]R_HSP46_r
// COMPILER_InspElmtVars 
//  ` added all vHSP46_1-_22 vars

//**********`Modified by: Costas Manousakis-(Designer)-(3/8/17)
//Method: Test_loadDataFromV11toV15
//Description
// test of data from v11 to v15 when fields added in v11 db AFTER the uuid field added in v15
// tables [RAILBridgeInfo] and [ElmtRatingLoads]
// populate new fields in  records of table. save the data for comparison. export records with send record
// load that export in a v15 db and verify if data read correctly
// Option ResetUUID will apply a new uuid to fields for [RAILBridgeInfo] and [ElmtRatingLoads]
// Option Load will load from a file created usind SEND RECORD for tables [RAILBridgeInfo] and [ElmtRatingLoads]

// Modified Method(s) : 
// ExportNBI_full
//  `fixed setting variable $item113 to have a length of 1

//**********`Modified by: Costas Manousakis-(Designer)-(3/9/17)

// Created Method(s) : 
//Method: INSP_PrintInspType
//Description
// Print current inspection according to its type. [Inspections] record must be loaded and checked before
// calling this method.
// Extracted code from INSP_PrintInspBtn_OM

// Modified Method(s) : 

// INSP_PrintInspBtn_OM
//  ` use INSP_PrintInspType
// INSP_Read_Write_Tables
//  `added [ElmtRatingLoads]

// Modified Object Methods : 
// Object Method: [Inspections];"InspectionReview".bzPrint
//  `use new method INSP_PrintInspType ; added declaration of INSP_PageCountDone_b;vbInspectionLocked
//  `use INSP_Read_Write_Tables and ut_db_RestoreROState

// Modified Method(s) : 
// INSP_ElmtLoadRated_OM
//  `no need to  assign values to the dummy filelds in [ElmtRatingLoads]

// ut_SQLDownloadNewRecords
//  `SORT ARRAY(ActivityKeys_al;>)  before getting the first and last refIDs to be received

// Created Method(s) : 
//Method: ARCHIVE_ExportNBI_full
//Description
// Create NBI export that includes records with missing NBI item data 
// is a copy of method ExportNBI_test excluding the SIA_DataCheck

//**********`Modified by: Costas Manousakis-(Designer)-(3/13/17)

// Modified Method(s) : 
//NTI_LoadElementHelp 
//PON_ExportCU2Migrator
//  //for 4D versions other than v11 use the v13 template

//**********`Modified by: Costas Manousakis-(Designer)-(3/15/17)
// Modified Method(s) : 
// F_CompressPic
//  `added if statement for application version to cause compile error in v11 to alert for v13
//  `in the v11 case use quicktime to compress the picture first then convert it to jpg ; 
//  `in v13+ compression is done with the convert command

// INSP_SavePhoto
//  `clean up code - compression and conversion to jpg is done only for BMS Photos.; 
//  `make sure photo is compressed even if it does not need to be reduced in size

// NTI_SaveImage
//  `make sure BMS Photos are JPEGS and compressed

//**********`Modified by: CJ MIller-(Designer)-(3/16/17)
// ut_CopyConvtertedPDFs
//  `changes 

//**********`Modified by: Costas Manousakis-(Designer)-(3/20/17)
// Modified Method(s) : 
// INV_SavePhoto
//  `make sure photos are compressed
// SCPOA_SaveImage
//  `make sure photos are compressed

// ExportNBI
//  `Do the ExportNBI_full only
// ExportNBI_full
//  `modified the errors alert

// Modified Forms : 
// Form Method: [InventoryPhotos];"Input"
//  `enabled contextual menu on picture variable - enabled on after edit event on picture variable
// Modified Object Methods : 
// Object Method: [InventoryPhotos];"Input".DE_InvPhoto
//  `added on after edit for the picture var because contextual menu was enabled


//```
//```   **** End of Release 6.6.4.e 20-Mar-2017
//```

//**********`Modified by: Costas Manousakis-(Designer)-(3/21/17)
// Created Method(s) : 
//Method: Temp_FixStdPhotoSizes
//Description
// fix the photosizes of standard photos


//**********`Modified by: Costas Manousakis-(Designer)-(3/23/17)
// Created Method(s) : 
//Method: NTI_LoadExportArrays
//Description
// load NTE export arrays for FHWA export for the current TIN record
// available trhough 4DACTION 4DMETHOD 4DSCRIPT

// NTI_ExportFHWANTE
//  `changes fot newly supplied xsd and fixes in the code. use process v_182_@ vars for the [NTI_ELEM_DEFS] arrays

//**********`Modified by: Costas Manousakis-(Designer)-(3/23/17)
// Created Method(s) : 
//Method: dev_mergeCodeAndDesc
//Description
// combine the code with the description Code:Description
// Parameters
// $1 : $PointertoDescription array
// $2 : PointerToCode Array

// Modified Method(s) : 
// InitProcessVar
//  //added code to display the item code with the description in dropdowns. use dev_mergeCodeAndDesc

//**********`Modified by: Costas Manousakis-(Designer)-(3/29/17)
// Modified Method(s) : 
// F_GetUserInitial
//  `fixed incorrect calculation for the initials

// NTI_ExportXML
//  `added choise for design user to consider approved,complete or any inspection found
// NTI_LoadExportArrays
//  `check if required to use approved or complete or any inspection

//**********`Modified by: Costas Manousakis-(Designer)-(3/31/17)
// Modified Method(s) : 
// Temp_FixStdPhotoSizes
//  `mods to read std photo ids from a file and log activity to file
// NTI_ExportXML
//  `Added option to export NTI only or NTI + NTEs
// ExportNBI
//  `Alert Design users to update Item75 data and FHWAItem 8 before the Final export


//End Mods_2017_03