//%attributes = {"invisible":true}
//27-Jan-2005

//Added Method
//SD_QryDateCheck 
//  `Check dates entered in form [SD_History];"QryForm"

//Modified Form Method
//[SD_History];"QryForm"
//  `Added code to initialize Variables ◊SD_BYear_s, ◊SD_EYear_s,
//  `◊SD_BMonth_s, ◊SD_EMonth_s

//Modified Form
//[SD_History];"QryForm"
//  `Applied StyleSheets; Changed default action of Print button to None; Added 
//  `object method in print button to check if Dates are OK.

//Modified Form Method
//[Inspections];"Inc. Inspection"
//  `Adjusted so that Spec. Mem. check is done only for RT@ and CUL inspections.
//  `Also use the InspRtnSpcMbFlag field for Version >=5.0
//*****Moved to Server....

//Modified Form Method
//[Inspections];"InspectionReview"
//  `Use the InspRtnSpcMbFlag field for Version >=5.0
//*****Moved to Server....

//Modified Methods
//G_Insp_SaveInspection
//G_Insp_SaveContinue
//  `Add code to save InspRtnSpcMemFlag flag and pushchange for
//  `versions >=5.0
//*****Moved to Server....

//Added Methods
//InitGrpDelete 
//PushGrpDelete 
//FlushGrpDeletions 
//TellServerGRD 
//XGetServerGRD 
//fGRDBlob2Text 
//fGRDBlob2Text_2 
//  `To implement Group Deletions : delete a set of records from same table with 
//  `same parent.

//Modified Form Methods
//[Activity Log];"Input"
//[Activity Log];"Output"
//[Activity Log];"Print"
//  `Modified code to address new GRD activity type.

//Modified Methods
//fGrpBlob2Text
//fGrpBlob2Text_2
//fBLOB_2_Text
//  `Clean out Local Blob, Picture and Text variables at the end.

//Modified Methods
//NewTellServer
//XDownLoadServer 
//  `Added calls to TellServerGRD and XGetServerGRD  methods

//Modified Method
//SD_ControlReport
//  `Added a check if there are any records in the SD History table.

//Modified Methods
//G_CleanUpInspection
//MakeInspection
//  `Use Grp Delete functions.

//Created Method
//Temp_IniInspCmbdFld
//  `Initialize field [Inspections]InspRtnSpcMemFlag
//*****Moved to Server....

//4-Feb-2005 ************

//Modified Method
//SD_ImportOldHistoryRecords
//  `Changed limits of max year to be current year.