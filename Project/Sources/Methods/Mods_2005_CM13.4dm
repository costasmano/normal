//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/27/05, 13:32:03
	// ----------------------------------------------------
	// Method: Mods_2005_CM13
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
End if 

// Modified Forms : 
//[Contract Invoice];"ContractInvoice In"
//  `Added Delete button to perform DeleteSubrecord.

// Modified by: costasmanousakis-(Designer)-(6/2/2005 15:04:17)
// Modified Methods : 
//Server_GenCondRep 
//  `Added code to export on server dbf files, using export settings files.

// Modified by: costasmanousakis-(Designer)-(6/3/2005 11:40:48)
// Modified Methods : 
//InitFOSDFields
//  `Added code to save changes to NBI record only if the SD FO status changes.
//  `Re-arranged code to check for ◊Abort; Declared ◊Abort variable at start.
//RecalcAASHTO
//  `Added code to save changes to NBI record only if items 67-70  or AASHTO  change.
//ut_StartMessage
//  `Added calls to make sure Platform vars are set and Characters are defined
//ut_Message
//  `Added code to add LF at end of CR if found for Win platform.

// Modified by: costasmanousakis-(Designer)-(6/13/05 10:57:09)
//Create New Form
//[Inspections];"SimpleInput"

// Modified by: costasmanousakis-(Designer)-(6/14/2005 16:50:13)
//Modified Methods
//XDownLoadServer
//  `Replaced ALERT("There are New Records") with a call to ut_MessageDia Timed dialog.
//  `Removed call to OP LOAD NETWORK Component- Set $Error:=0
//GetServerBIN 
//MHD_GetSIA 
//NewTellServer 
//TestRemoteSeq 
//TestServerID 
//  `Removed call to OP LOAD NETWORK Component- Set $Error:=0
//M_ListServers 
//  `Use only TCP component
//  `Removed call to OP LOAD NETWORK Component- Set $Error:=0

// Modified by: costasmanousakis-(Designer)-(6/15/2005 14:34:02)
// Modified Object Methods : 
//[Contract Assignments];"Assignments In".btnRetrieveCost
//  `Fixed logic when recalculating costs - use GOTO Selected record instead of First record,
//  `Next record.

// Modified by: costasmanousakis-(Designer)-(6/20/2005 10:49:12)
//Modified Table
//[RatingReports]
//  `Added field  [RatingReports]StructRpt per Request F.Rastegari

// Modified Forms : 
//[RatingReports];"RatReportsIn"
//  `Added Structural Report/Partial Calc checkbox. Adjusted size and location of other 
//  `fields on page 1.  Do not PushChange on the StructRept field.

// Modified Forms : 
//[Inspections];"Dive Form"
//[Inspections];"Dive LowCl"
//[Inspections];"Underwater Special Member"
//[Inspections];"Dive Template"
//  `Adjusted entry order, made display of inspection date consistant mm/dd/yyyy forced,
//  `made tab control Mac Theme.

// Modified by: costasmanousakis-(Designer)-(6/21/2005 10:51:37)
// Modified Methods : 
//XGetServerGrp
//  `Fixed bug which did not check the proper fieldno variable.

// Modified by: costasmanousakis-(Designer)-(6/27/2005 14:24:00)
//Added Method:
//ut_CheckEmployeeID

// Modified by: costasmanousakis-(Designer)-(6/29/2005 11:41:39)
// Modified Methods : 
//StartControlSrvProc
//  `Added 5 minute delay before launching ControlServerProcesses.

// Modified Form Methods : 
//[Inspections];"Dive Form"
//[Inspections];"Dive LowCl"
//[Inspections];"Underwater Special Member"
//  `Added Missing call to FlushGrpChanges for Combined inspections record.

// Modified Object Methods : 
//[Inspections];"Dive Template".bSaveContinue
//  `Added Missing call to FlushGrpChanges for Combined inspections record.
//  ` Modified by: costasmanousakis-(Designer)-(7/1/2005 08:16:05)
//  `Added InitChangeStack(4) call.