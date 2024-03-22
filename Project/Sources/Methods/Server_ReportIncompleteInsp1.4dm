//%attributes = {"invisible":true}
//Method: Server_ReportIncompleteInsp1
//Description
// copy of Server_ReportIncompleteInsp to run at a different schedule
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/29/18, 09:47:18
	// ----------------------------------------------------
	//Created : 
	Mods_2018_06_bug
	
End if 
//

INSP_ReportIncompleteInsp

ut_SetNextRunTimeStamp(Current method name:C684)

//End Server_ReportIncompleteInsp1