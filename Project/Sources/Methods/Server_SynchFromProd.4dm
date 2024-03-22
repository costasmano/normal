//%attributes = {"invisible":true}
//Method: Server_SynchFromProd
//Description
//  `  Run ut_SynchFromProd in a server process
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/31/13, 08:39:35
	// ----------------------------------------------------
	//Created : 
	Mods_2013_07
	
End if 
//
ut_SynchFromProd

ut_SetNextRunTimeStamp(Current method name:C684)

//End Server_SynchFromProd