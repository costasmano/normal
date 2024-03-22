//%attributes = {"invisible":true}
//Method: Client_DisableLogs
//Description
// disable logs on a client - meant to be used by execute on client
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Mar 6, 2023, 12:11:58
	Mods_2023_03
	// ----------------------------------------------------
	
End if 
//
SET DATABASE PARAMETER:C642(Debug log recording:K37:34; 0)  // disable plugin calls
SET DATABASE PARAMETER:C642(Client log recording:K37:44; 0)
SET DATABASE PARAMETER:C642(Diagnostic log recording:K37:69; 0)

//End Client_DisableLogs   