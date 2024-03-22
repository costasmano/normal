//%attributes = {"invisible":true}
//Method: Mods_2016_10
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/11/16, 11:29:09
	// ----------------------------------------------------
	//Created : 
	Mods_2016_10
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(10/7/16)
// Modified Forms : 
//[Bridge MHD NBIS];"RailTransitSIA"
//  `Fixed label for CommuterRtg 286K car

// Modified Method(s) : 
//ut_ControlUserPrefs 
//Compiler_Preferences 
//  `added  boolean ◊pref_New4DWR to use  new method of printing 4D Write comments in inspeciton reports

// Modified Method(s) : 
//Print_Dive_Cmt_a_new 
//Print_RTN_Cmts 
//Print_CUL_Cmts 
//INSP_FRZ_PrintCmts 
//Print_Tunnel_Cmts 
//  `call to Insp_PrintRemarks when  ◊pref_New4DWR is true


// Created Method(s) : 
//Test_Pontis_4D_compare
//Test comparing inspection data between the pontis db and the Boston server
// to match inspections in 4D with inspections in Pontis to get the INSPKEY

//**********`Modified by: Costas Manousakis-(Designer)-(10/11/16)
// Modified Method(s) : 
//SIA_UpdSelList
//  ` write the $summary text in the report file

// Created Method(s) : 
//ACTLOG_CheckFileID
//Description
//Check the FileIDRes table for duplicates

// Modified Forms : 
//[Bridge MHD NBIS];"RailTransitSIA"    -- copied to v15
//  `Added 315K label and fields in "CommutRtg_@" group

//**********`Modified by: Costas Manousakis-(Designer)-(10/12/16)
// Created Method(s) : 
//QR_CalcDistrRank
//Description
// calculate the district rank of the current Bridge or by passing BIN and Item2 and Rank
// Parameters
// $0: $DistrRank_L
// $1 : $BIN  (Optional)
// $2 : $Item2  (Optional)
// $3 : $Rank  (Optional)

// Modified Method(s) : 
//COMPILER_QRMethods 
//  `added QR_CalcDistrRank

//**********`Modified by: -(10/13/16)
// Created Method(s) : 
//Method: QR_ReturnPhotoType
//Description
// return result of hmFree_GET PICTURE TYPES 
// Parameters
// $0 : $TypesFound_atxt
// $1 : $PicPointer

// Modified Method(s) : 
//COMPILER_QRMethods 
//  `added QR_ReturnPhotoType

// Modified Method(s) : 
//F_CompressPic
//  `added comments for Compress picture in case of v13+ versions use $vPicQual parameter


// Modified Method(s) : 
//ut_ControlDBSycnh
//  `Added check to verify that we there are no existing FileIDRes entries when sending a NRC activity
//ut_SQLDownloadNewRecords
//  `Added check to verify that we there are no existing FileIDRes entries when receiving a NRC activity

//**********`Modified by: -(10/14/16)
//INSP_SavePhoto
//  `Added code to make sure we do not miss changes in type, or if the photo has been changed by looking in ptr_Changes{2}
//  ` also check for image type - if a pict and a photo - convert immedialtely to jpg; prevent any pdfs; prevent picts in sketches/charts

//**********`Modified by: -(10/17/16)
// Method: Object Method: [Standard Photos];"Standard Photos".Button
//  `added display of image type.

// Modified Method(s) : 
//SIA_SetUpListBoxes
//  `made columns 2 and 4 for Inspections -page 7 (item 41 and item 59) to variables - so the can be blank for Freeze thaw reports
//SIA_OnDisplayDetail
//  `for inspections columns 2 and 4 need assigning; added case for "FRZ" reports to hide item41 and ratings

// Modified Method(s) : 
//ut_setPrefSMTPServer
//  `set ◊pref_New4DWR:=True

//```
//```   **** End of Release 6.6.2 17-Oct-2016
//```


//**********`Modified by: Costas Manousakis-(Designer)-(10/19/16)
// Modified Method(s) : 
//ut_ControlUserPrefs
//  `Added "EDIT" option to bring up dialog to edit all preferences in <>PrefNames_atxt with a list box

// Created Form(s) : 
//"EditPrefs"
//  //Edit preferences


//**********`Modified by: -(10/20/16)
// Modified Method(s) : 
//Inc_Sequence
//  `Increased Delay process to 60 when not in transaction; Added IDLE ; and a message when the sequence is locked
//  `Increased Delay process to 15 when in transaction; Added IDLE before and after delay process
//ut_AssignNextNumber
//  `Increased Delay process to 30; Added IDLE 


//**********`Modified by: Costas Manousakis-(Designer)-(10/21/16)
// Modified Method(s) : 
//LSS_PrintInspection
//  `set print preview to false at startup

//**********`Modified by: Costas Manousakis-(Designer)-(10/21/16)
// Modified Method(s) : 
//WRUTIL_Function
//  `Added code in CLEANCHARS to remove bullets that are to the left of the left margin

//**********`Modified by: Costas Manousakis-(Designer)-(10/24/16)
// Created Method(s) : 
//PON_ExportToBrM 

//**********`Modified by: Costas Manousakis-(Designer)-(10/25/16)
// Modified Method(s) : 
//ut_ControlUserPrefs 
//  `default ◊pref_New4DWR to True on INIT

//Print_Dive_Cmt_a_new 
//Print_RTN_Cmts 
//Print_CUL_Cmts 
//INSP_FRZ_PrintCmts 
//Print_Tunnel_Cmts 
//  `allow designer to pick option of printing method

//Compiler_Preferences 
//  `added CBUseOriginalWR

//INSP_PrintInspBtn_OM 
//  `added call to NTI_INIT before printing tunnel inspections
//ut_setPrefSMTPServer 
//  `remove set ◊pref_New4DWR:=True

//M_HandlePrefs 
//  `added code for ◊pref_New4DWR

//PON_ValidateElemInput 
//  `make sure scale factor is not 0 (zero)

// Modified Forms/Method : 
//"Preferences"
//  `Added CBUseOriginalWR for ◊pref_New4DWR

// Modified Forms : 
//  `modified the 'form names' at bottom left of border of the 4D WRITE print forms

// Modified Method(s) : 
//ControlMenuBar
//  `enable preferences for external users

//```
//```   **** End of Release 6.6.2.a 25-Oct-2016
//```


//**********`Modified by: Costas Manousakis-(Designer)-(10/31/16)
// Modified Method(s) : 
//ImportFEDrecord_Item8
//  `moved messages where the input file is; open input file in RO mode
//  `For records not found, write in message file info so they can be located.

//G_FormatItm6466
//  `changed rating formats to allow more numbers in front

// Modified Forms : 
//[Activity Log];"Output" 
//  `made Local and Parent ID fields wider

// Modified Method(s) : 
//P_ReviewChanges
//P_ReviewLogged
//  `use width of output form for the window

//End Mods_2016_10