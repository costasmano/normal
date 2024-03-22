//%attributes = {"invisible":true}
//Method: Server_ReportIncompleteInsp
//Description
// Send reports on incomplete inspections exceeding 60 or 90 days
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 05/15/18, 16:23:09
	// ----------------------------------------------------
	//Created : 
	Mods_2018_05  //Write method to report on inspections still not completed withing 60 or 90 days
	//Modified by: Chuck Miller (5/17/18 17:54:34)
	// Modified by: Costas Manousakis-(Designer)-(6/29/18 09:46:01)
	Mods_2018_06_bug
	//  `use new method INSP_ReportIncompleteInsp - this way can have multiple schedules.
End if 
//

INSP_ReportIncompleteInsp

ut_SetNextRunTimeStamp(Current method name:C684)
//End Server_ReportIncompleteInsp