//%attributes = {"invisible":true}
// Method: LOGIN_BMSPontisTransfer
// Description
// Login method for User BMSPontis Transfer
// 
// Parameters
// $1 : $text - if not passed launches itself in a new process
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Administrator
	// Date and time: 06/18/07, 08:57:15
	// ----------------------------------------------------
	//
	// Launches
	M_Quit
	// ----------------------------------------------------
	
	// Modified by: costasmanousakis-(Designer)-(2/27/09 10:55:59)
	Mods_2009_CM_5404
	//  `Added a call to method ut_updateCMAssgnABP
	// Modified by: C Miller-(Designer)-(3/11/14 09:45:00)
	Mods_2014_03
	//  `Launch in a separate process
	// Modified by: Costas Manousakis-(Designer)-(8/27/14 15:11:49)
	Mods_2014_08
	//  `Added at the start maximo_UpdateMaximo
	// Modified by: Costas Manousakis-(Designer)-(11/12/2020 )
	Mods_2020_11_bug
	//  `Disable Maximo and Pontis update
	Mods_2022_03  //Delete obsolete code that related to ODBC Pro
	//Commented out ut_UpdatePontis
	//Modified by: Chuck Miller (3/25/22 12:44:43)
End if 

If (Count parameters:C259=1)
	C_TEXT:C284($1)
	
	If (False:C215)
		//ut_UpdatePontis 
		
	End if 
	
	ut_PRJCtrlRetrieveProjectData
	
	ut_updateCMAssgnABP
	
	If (Current user:C182="BMSPontis Transfer")
		//Quit ..
		C_LONGINT:C283($newPID)
		$newPID:=New process:C317("M_QUIT"; 0; "Quitting!!")
	End if 
	
Else 
	C_LONGINT:C283($ProcessID_L)
	$ProcessID_L:=New process:C317("LOGIN_BMSPontisTransfer"; 0; "LOGIN_BMSPontisTransfer"; "1")
	
End if 