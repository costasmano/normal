//%attributes = {"invisible":true}
//Method: Mods_2014_06_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/06/14, 13:23:02
	// ----------------------------------------------------
	//Created : 
	Mods_2014_06_bug
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(6/6/14)
// Modified Forms : 
//[Bridge MHD NBIS];"Bridge Input"
//  `removed dispaly filter on Bridge Name in the  pages.


// Modified Method(s) : 
//INSP_PrintInspBtn_OM
//  `load tunnelinfo record before tables are set to RW

//SIA_ControlDoubleClick 
//  `Load the TunnelInfo record  as RO after closing a Tunnel inspection

// Modified Forms : 
//[Inspections];"TunnelReprtTemplate"
//  `adjusted Contracts size and area to better fit the cotnract numbers

//[Inspections];"TunnelRoutinePg1"
//[Inspections];"TunnelOverPg1"
//  `moved some elements down to adjust for change in template

//**********`Modified by: Costas Manousakis-(Designer)-(6/9/14)
//ut_SQLTellServerNRC
//  `fixed wrong error code for Duplcate key error - and prevent propagation of NRC  activity to other databases

//**********`Modified by: Costas Manousakis-(Designer)-(6/10/14)
// Modified Method(s) : 
//ut_SQLCreateNewRecord
//  `Fixed the error code used when checking for duplicate key error.  Catch any other errors. if table is not on ignrore list , or not a duplicate key error.
//  `Added writing of the error stack at that point also.

//ut_SQLDownloadNewRecords
//  `add  ut_SQLWriteErrorsToLog if an error returning the remote act log record 

//**********`Modified by: Costas Manousakis-(Designer)-(6/13/14)
// Modified Method(s) : 
//G_Insp_FmtSTOWN
//  `replaced the logic with a call to ut_FitPrintFormObject


//**********`Modified by: Costas Manousakis-(Designer)-(6/17/14)
// Modified Method(s) : 
//Print_Freeze_pg1
//INSP_FRZ_PrintCmts
//Compiler_Inspections
//  `Added code to print the Orientation text if it does not fit on page 1

// Modified Forms and method :
//[Inspections];"FrzThawPg1A" 
//  `Added code to print the Orientation text if it does not fit on page 1
//  `Use var FRZ_OrientationPg1_txt

//**********`Modified by: C J M(Designer)-(6/19/14)
// Modified Method(s) : 
//maximo_UpdateMaximo 
//  `added more messages to troubleshoot compiled version
//  `changed all variables used in SQL EXECUTE statements to process variables so that it works compiled

//Compiler_maximo
//  `added declarations for proc vars for the SQL  statements in  SQL EXECUTE in maximo_updatemaximo

//SQL_ERROR 
//  `temporarily added code to write the error codes

//**********`Modified by: Costas Manousakis-(Designer)-(6/20/14)
// Modified Forms : 
//[ScourPOA];"Input-A"
//  `Fixed label page 10 - "First 6 photos"

// Modified Form Methods : 
//[Bridge MHD NBIS];"SI & A Input" 
//  `change entry filter for item 5 for  TNL, BTS, BLD records to allow a 2;A-Z = Under  record per coding guide


// Modified Form Methods : 
//[InventoryPhotoInsp];"Input"
//  `Enabled tunnel inventory photo types

// Modified Method(s) : 
//LST_SetUpForArchive
//  `Added  SAVE RECORD In the =New Record case
//  `removed the case of 4D version - not needed anymore 
//  `moved the Flush and save and validate trans at end.

// Modified Forms : 
//TableOfLists.i
//  `assigned ENTER key as shortcut to validate button - change action of valicdate to No action

//**********`Modified by: Costas Manousakis-(Designer)-(6/24/14)
// Modified Table(s) : 
//[TableOfLists]
//  `made field [TableOfLists]ListKeyID_L unique and not null


//```
//```   **** End of Release 6.3.2.a Version 06/24/2014
//```

//**********`Modified by: Costas Manousakis-(Designer)-(6/27/14)
// Modified Method(s) : 
//Compiler_SD
//  `added SD_Detail_prt_l (◊SD_Detail_l was being reset when form was printed)

// Modified Forms : 
//[SD_History];"SummaryHeader.rpt"
//  `changed name of Detail Report chk box to a process var assigned on printing detail


//End Mods_2014_06_bug