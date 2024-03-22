//%attributes = {"invisible":true}
//12-Jan-2005 *********


//Modified Form:

//[Conslt Rating];"View Cslt Rating"

//  `Changed FirstExpSubmittal buttons to put the 'Arrow' button behind 

//  `the 'sort' button. Changed Form Horizontal Margin to 20.


//Modified Object Code:

//[Conslt Rating];"View Cslt Rating".Sort1stExp

//  `Was assigning $viNewValue to wrong variable.


//Modified Method

//P_ListConsRating

//  `Use Output form width for window size.


//14-Jan-2005 *********


//Modified Tables:

//[Activity Log]

//[FileIDRes Table]

//[Owners of Data]

//  `Changed Load Privileges to 'ReadWrite' group from 'ActiveUsers'


//19-Jan-2005 *********


//Modified Menu

//  `Allowed 'ActiveUser' access to menu Reports->Bridge Status


//Modified Form Method

//[Status Report];"O_StatusReport"

//  `Added code to disable Add and Delete buttons for Readonly users.

//[Status Report];"I_StatusReport"

//  `Added code to disable Delete button and Comments field for Readonly users.


//20-Jan-2005 *********


//Indexed fields:

//[Contracts]ContractID

//[Contract FundTransfer]TOF_ID

//[Contract ExtendTime]EOT_ID

//[Contract Assignments]AssignID

//[Contract AddFund]AddFund_ID


//Modified Form

//[Inspections];"Dive Pr Pg 2 wrt"

//  `Replaced vertical frame lines and bottom horizontal line that were

//  `2pts thick with filled rectangles. to fix bug in v2003 which

//  `causes bottom part to get printed as hairlines.


//25-Jan-2005 *********


//Modified Method:

//G_InspParagProt

//  `Fixed If statement where the check was made if the 'Cont'd title 

//  `is ready to be added in the proper page to avoid placing it at the

//  `bottom of the previous page.


//Modified Form Methods:

//[Bridge MHD NBIS];"Bridge Input"

//[Bridge MHD NBIS];"NBIS Stack Info"

//  `Removed code changing window size from the [Bridge MHD NBIS];"Bridge Input"

//  `to the [Bridge MHD NBIS];"NBIS Stack Info" method. Added On Open/Close detail

//  `events to change and restore window size.


//Modified Forms:

//[ElementsSafety]; * All Input Forms

//[Standard Photos];"Standard Photos"

//[Inspections];"Closed Bridge"

//[Inspections];"Critical Member"

//[Inspections];"Damage Form"

//[Inspections];"Dive Form"

//[Inspections];"Dive LowCl"

//[Inspections];"Underwater Special Member"

//[Inspections];"Dive Template"

//  `Applied Stylesheets to all objects, set Appearance to Automatic


//Created new Table:

//[ClientAccess]

//  `Per code from Chuck Miller to implement a Client Messaging system.


//Created New Forms:

//[ClientAccess];"Input"

//[ClientAccess];"Output"

//[Dialogs];"BigAlert"

//  `Per code from Chuck Miller to implement a Client Messaging system.


//Created New Methods

//ut_BigAlert

//ut_LoadRecord

//ut_CreateTimeStamp

//CA_fAllowLogins

//CA_SetLoginToDisable

//  `Per code from Chuck Miller to implement a Client Messaging system.


//Modified Database Method

//On Startup

//  `Per code from Chuck Miller to implement a Client Messaging system.


//26-Jan-2005 ************


//Added Field

//[Inspections]InspRtnSpcMemFlag : Boolean


//Modified Method

//Duplicate_Inspection

//  `Modified code that excludes [Inspection] fields from getting loged.

//  `Added code to check Application version for which fields are to be skipped


//Modified Method

//G_AddHeader

//  `Changed header for "APP" to "APPROACHES" from "APPROACH"


//Modified Method

//MakeInspection

//  `Added initialization of field [ElementsSafety]Weld Condition to "N"


//01-Feb-2005 ************


//Modified Menu items:

//Menu bar #4/Utilities/

//  `Renamed "Interoffice Memo to In-House, Consultant" to 

//  `"Transmittal to In-House/Consultant"


