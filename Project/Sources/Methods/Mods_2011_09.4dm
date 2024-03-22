//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/06/11, 14:06:04
	// ----------------------------------------------------
	// Method: Mods_2011_09
	// Description
	
	Mods_2011_09
End if 

// **********  ` Modified by: costasmanousakis-(Designer)-(9/6/11 16:15:46)
// Modified Form Methods : 
//[Dialogs];"InspectConfig"
//  `Added  "OTHER" inspection to the dive group

// Created Method(s) : 
//ut_ImportFHWADataToArchive
//  ` Read an input text file and load into the Archive tables 
// Parameters
// $1 : $Task ("START";"LOADREC")
// $2 : $SecondtParam_txt - Depends on task
//  `  ` LOADREC : $2 = Record Line
// $3 : $ThirdParma_txt - depends on Task
//  `  ` LOADREC : $3 = Primary or Secondary record

// **********  ` Modified by: costasmanousakis-(Designer)-(9/12/11 16:05:20)
// Modified Method(s) : 
//G_WRT_MakeDocument
//  `Restore the Templates record loaded at the start of this method - was causing problems in making multiple letters in a row

// **********  ` Modified by: CJ Miller`09/16/11, 12:50:17      
// Created Method(s) : 
//LST_SetUpForArchive
//  ` Create Activity Log records for the Table of Lists
// Modified Form Methods : 
//[TableOfLists];"TableOfLists.i"
//  `Added Transaction start
// Modified Object Methods : 
//[TableOfLists];"TableOfLists.i".bValidate
//[TableOfLists];"TableOfLists.i".bFirst
//[TableOfLists];"TableOfLists.i".bPrevious
//[TableOfLists];"TableOfLists.i".bNext
//[TableOfLists];"TableOfLists.i".bLast
//  `Use method LST_SetUpForArchive

//[TableOfLists];"TableOfLists.i".bDelete
//  ` Type all local variables for v11
//  `Create entries in the ACtivity log
//[TableOfLists];"TableOfLists.i".bCancel
//  `Cancel Transaction

// **********  ` Modified by: costasmanousakis-(Designer)-(9/16/11 12:51:40)
// Created Method(s) : 
//ut_sendInspActLogs2Dist
//  ` Designate Act Log records to be received by a District.  to be run on Boston server

// Created Fomr(s) : 
//[BridgeMHDNBISArchive];"AllData"
//[NBISSecondaryArchive];"AllData"

// Created Method(s) : 
//ARCHIVE_InitFOSDFields
//  ` copied from :InitFOSDFields
//  `Modified for table [BridgeMHDNBISArchive]
// ARCHIVE_RecalcAASHTO
// ReCalc aashto for selected [BridgeMHDNBISArchive] records

// Modified Method(s) : 
//ARCHIVE_FOSDFields
//  `Use the current selection of archive records

// Created Method(s) : 
//ARCHIVE_UpdateSDFO
//  ` Run the RecalcAASHTO and update SD FO foe a selection of Arhcive records
//  QR_ArchiveFunction
//  ` Quick report function to be used when the master table is the [BridgeMHDNBISArchive] table
//  ` communicates with ut_QRARCHIVEFUNCTION using process variables and sempahore "ARCHIVEFUNCTION"
//  ` will launch ut_QRARCHIVEFUNCTION if it has not started yet.
//ut_QRARCHIVEFUNCTION
//  ` Method to get info from the [BridgeMHDNBISArchive] table and passing it to a calling 
//  ` process using interprocess communication
//ut_charscan
//  ` Clean characters from a text

//SIA_FieldPtr 
//  `  ` return a pointer to an SIA field from a table - to match the name of a field in the main table
//  ` Parameters
//  ` $0 : $Fld_ptr
//  ` $1  : $Table_L : table for which to return the field
//  ` $2 : $SIAFld_ptr : pointer to a field in another table. used to get the name of a field in table $1

//QR_SearchArchive
//  ` Search the bridge archive table for a record base on the Reason, date, and BIN and return the value of a field in text
//  ` Parameters
//  ` $0 : $ARCH_Result_txt
//  ` $1 : $ARCH_Reason_txt
//  ` $2 : $ARCH_Date_d
//  ` $3 : $ARCH_BIN_txt
//  ` $4 : $ARCH_Field_ptr
//  ` $5 : $ARCH_Fmt_txt (optional)

//QR_Archive_InspFreq 
//  ` Calculate the inspection frequency from the Archive tables
//  `Parameters
//  ` $0 :$Freq_L
//  ` $1 :$StartYr_L
//  ` $2 :$EndYr_L
//  ` $3 :$BIN_txt


// Created Method(s) : 
//ARCHIVE_Diffs
// ` Find arrays of BINs added and removed between a starting and an ending
// ` monthly date form the [BridgeMHDNBISArchive] table
//  ` ***** DESIGN IN PROGRESS *****

//ut_ConstructXMLSpreadSheet
//  ` This method creates a template that builds an XML Spreadsheet output  
//  `. The template is returned as a text variable. 

//INSP_ReAssignDBIE 
//   ` Assign new dbie to a list of inspections

//ut_exportQRtoExcel 
//  ` Loads a Quick report from a file and performs an export to an Excel XML file

//GetType 
// `Description: This method returns the type of data.

//Text_toURL 
//converts Text to URL Chars

// Modified Forms : 
//[BridgeMHDNBISArchive];"Output"
//  `Added button ARCH_TOOL_BTN_L
//  `Tools drop down menu

// **********  ` Modified by: costasmanousakis-(Designer)-(9/20/11 17:00:16)
// Modified Method(s) : 
//DCM_DailyControl_OM 
//  `Added short message on the SAVE task

// **********  ` Modified by: costasmanousakis-(Designer)-(9/22/11 16:59:22)
// Modified Forms : 
//[RatingMember];"RatElmInc"
//[RatingReports];"RatReportsIn"
//  `modified forms to allow horizontal growth for the rating member include form.

// **********  ` Modified by: costasmanousakis-(Designer)-(9/23/11 14:31:04)
// Created Method(s) : 
//ut_UnsortTableFields
//  ` Show Tables and fileds unsorted!

// Modified Method(s) : 
//ARCHIVE_Store
//  `When no parameters are passed Ask for reason and date of archive - for NBI tape ask for the year.

//QR_Archive_InspFreq
//  `account for Item 91 found on the first set of data

// Created Method(s) : 
//ut_openDataFile
//  ` Open another data file


// **********  ` Modified by: costasmanousakis-(Designer)-(9/26/11 10:39:10)
// Modified Method(s) : 
//Reapply_MakeNewLogEntry 
//LogLink 
//FlushGrpDeletions 
//FlushGrpChgs 
//LogNewRecord 
//LogDeletion 
//LogChanges
//  `Do not create an [Owner] record when ◊Transfer = -1  (No transfer)
//  `Allows user who created the record to be able to download it as himself from
//  `his copy of the database

// Modified Table(s) : 
//[NBISSecondaryArchive]
//  `Made table visible - help with importing records from other DBs

// Created Method(s) : 
//QR_Archive_LastInsp
//  ` Get the Last inspection date recorded in an Archive BIN record
// Parameters
// $0 : $LastDate_d
// $1 : $ArchiveReason_txt
// $2 : $BIN_txt
// $3 : $Archivedate_d

// Modified Method(s) : 
//GetDBIEinfo 
//GetUOEInfo
//  `Use GRP_GetGroupMembInfo to determine the DBIE info

//GetAreaBIEinfo 
//  `Generate new variable AreaBIEDistricts_txt, use GRP_GetGroupMembInfo to determine Area Engineer info

//M_WRT_CsltInsp_Review
//  `Use the new variable AreaBIEDistricts_txt from GetAreaBIEinfo

// Created Method(s) : 
//GRP_GetGroupMembInfo
// ` Get the member infor for a group
// Parameters
// $0 : $PersonID_L
// $1 : $GroupName_txt
// $2 : $Name_ptr
// $3 : $Initial_ptr
// $4 : $Suffix_ptr
// $5 : $Phone_ptr (optional)
// $6 : $Email_ptr (optional)
// $7 : $Acting_ptr (optional)

// **********  ` Modified by: costasmanousakis-(Designer)-(9/27/11 14:29:31)
// Created Method(s) : 
//SIA_FindMissingBDEPTs
//  ` Find the Missing BDEPTS in a list of Bridges - Works from current selection
//  ` or from a specified town

// **********  ` Modified by: costasmanousakis-(Designer)-(9/28/11 14:29:31)
// Modified Table(s) : 
//[Conslt Rating]
//  `added fields [Conslt Rating]DateReceivedByROUnit1,2,3,4 [Conslt Rating]NBISLetterPostStatus_s

// Modified Form(s) : 
//[Conslt Rating];"Cslt Rating In"
//  `Added new fields [Conslt Rating]DateReceivedByROUnit1,2,3,4 [Conslt Rating]NBISLetterPostStatus_s
//  `and a drop down to populate the NBISLetterPostStatus_s.
//  `Adjusted the size of the form
