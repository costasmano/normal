
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 05/26/16, 15:31:55
//----------------------------------------------------
//Method: Form Method: CNV_RunningProcesses
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_10  // 
	//Modified by: administrator (5/26/16 15:31:57)
	
End if 
If (Form event code:C388=On Activate:K2:9)
	REDRAW:C174(CNV_RunningProcess_aB)
End if 
//End Form Method: CNV_RunningProcesses

