//%attributes = {"invisible":true}
//Method: PON_SendNBItoBrM
//Description
// send NBI records to BrM
// this method is designed to be run manually in it's own process ie initiated by a user
// can only be run on a windows enviroment.
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/08/19, 15:33:44
	// ----------------------------------------------------
	//Created : 
	Mods_2019_07
	// Modified by: Costas Manousakis-(Designer)-(2023-04-14 10:56:12)
	Mods_2023_04
	//  `Added use of parameter PON_BRMODBCName to define the ODBC name
End if 
//

SET ASSERT ENABLED:C1131(True:C214; *)

ASSERT:C1129((Folder separator:K24:12#":"); "This should only run on windows!")

READ ONLY:C145(*)  // everything is read only
Progress QUIT(0)

C_TEXT:C284($BRM_DBName_txt; $BRM_ODBC_txt)
$BRM_DBName_txt:=ut_GetSysParameter("PON_BRMDBName"; "[BRM53].")
$BRM_ODBC_txt:=ut_GetSysParameter("PON_BRMODBCName"; "BRM")
//$BRM_DBName_txt:=""  //testing if this works
C_DATE:C307($LastBrMUpdate_d)
$LastBrMUpdate_d:=!2015-07-05!
C_TEXT:C284($LastBrMNBIUpdate_txt)
$LastBrMNBIUpdate_txt:=ut_GetSysParameter("PON_LastBrMNBIUpdate"; "07/05/2015")

If (Date:C102($LastBrMNBIUpdate_txt)>!00-00-00!)
	$LastBrMUpdate_d:=Date:C102($LastBrMNBIUpdate_txt)
Else 
	
End if 

ut_SetMessageDir("BMStoBrMTransfers")
C_TEXT:C284($LogFileName_txt)
$LogFileName_txt:="SendNBItoBrM-"+ut_ReturnTimeStampFromDate(Current date:C33(*); Current time:C178(*))
ut_StartMessage(2; $LogFileName_txt)

QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]DateModified:194>=$LastBrMUpdate_d)
QUERY:C277([Bridge MHD NBIS:1];  & [Bridge MHD NBIS:1]FHWARecord:174=True:C214)

ORDER BY:C49([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BDEPT:1; >)

C_LONGINT:C283($BridgeRecords_L; $bridge_L; $BridgeCount_L)

$BridgeRecords_L:=Records in selection:C76([Bridge MHD NBIS:1])

C_TEXT:C284($sql_txt)
ARRAY TEXT:C222($AllCommands_atxt; $BridgeRecords_L)
//start the bar
C_OBJECT:C1216($BridgeProgress_o)
$BridgeProgress_o:=ProgressNew("SQL for "+String:C10($BridgeRecords_L; "###,###")+" NBI bridges"; $BridgeRecords_L; True:C214; " Bridges"; 3)
ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : Start generating SQL commands for "+\
String:C10($BridgeRecords_L)+" NBI bridge records\n")
$BridgeCount_L:=0
For ($bridge_L; 1; $BridgeRecords_L)
	$BridgeCount_L:=$BridgeCount_L+1
	GOTO SELECTED RECORD:C245([Bridge MHD NBIS:1]; $bridge_L)
	LOAD RECORD:C52([Bridge MHD NBIS:1])
	//update progress
	UpdateProgressNew($BridgeProgress_o; $bridge_L)
	
	$sql_txt:=SQL_sp_Update_NBI_Data
	$AllCommands_atxt{$bridge_L}:="Execute "+$BRM_DBName_txt+"[dbo]."+"[sp_pontis_Update_NBI]"+" "+$sql_txt  //+";\n"
	
	//check if progress stopped
	If (Progress Stopped(OB Get:C1224($BridgeProgress_o; "progress"; Is longint:K8:6)))
		//abort loop
		$bridge_L:=$BridgeRecords_L+1
	End if 
	
End for 

//quit progress
Progress QUIT(OB Get:C1224($BridgeProgress_o; "progress"; Is longint:K8:6))
//
ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : End of generating of SQL commands for "+\
String:C10($BridgeCount_L)+" NBI bridge records\n")
If ($BridgeCount_L#$BridgeRecords_L)
	//resize the array if needed
	ARRAY TEXT:C222($AllCommands_atxt; $BridgeCount_L)
End if 

//do the non-NBI
QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]DateModified:194>=$LastBrMUpdate_d)
QUERY:C277([Bridge MHD NBIS:1];  & [Bridge MHD NBIS:1]FHWARecord:174=False:C215)

ORDER BY:C49([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BDEPT:1; >)

C_LONGINT:C283($BridgeRecords_L; $bridge_L; $BridgeCount_L)

$BridgeRecords_L:=Records in selection:C76([Bridge MHD NBIS:1])

C_TEXT:C284($sql_txt)
ARRAY TEXT:C222($AllNonNBICommands_atxt; $BridgeRecords_L)
//start the bar
C_OBJECT:C1216($BridgeProgress_o)
$BridgeProgress_o:=ProgressNew("SQL for "+String:C10($BridgeRecords_L)+" NonNBI bridges"; $BridgeRecords_L; True:C214; " Bridges"; 3)
ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : Start generating SQL commands for "+\
String:C10($BridgeRecords_L)+" NonNBI bridge records\n")
$BridgeCount_L:=0
For ($bridge_L; 1; $BridgeRecords_L)
	$BridgeCount_L:=$BridgeCount_L+1
	GOTO SELECTED RECORD:C245([Bridge MHD NBIS:1]; $bridge_L)
	LOAD RECORD:C52([Bridge MHD NBIS:1])
	//update progress
	UpdateProgressNew($BridgeProgress_o; $bridge_L)
	
	$sql_txt:=SQL_sp_Update_NonNBI_Data
	$AllNonNBICommands_atxt{$bridge_L}:="Execute "+$BRM_DBName_txt+"[dbo]."+"[sp_pontis_Update_NonNBI]"+" "+$sql_txt  //+";\n"
	
	//check if progress stopped
	If (Progress Stopped(OB Get:C1224($BridgeProgress_o; "progress"; Is longint:K8:6)))
		//abort loop
		$bridge_L:=$BridgeRecords_L+1
	End if 
	
End for 

//quit progress
Progress QUIT(OB Get:C1224($BridgeProgress_o; "progress"; Is longint:K8:6))
//
ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : End of generating of SQL commands for "+\
String:C10($BridgeCount_L)+" Non-NBI bridge records\n")
If ($BridgeCount_L#$BridgeRecords_L)
	//resize the array if needed
	ARRAY TEXT:C222($AllNonNBICommands_atxt; $BridgeCount_L)
End if 

//connect to BrM SQL
SQL LOGIN:C817("ODBC:"+$BRM_ODBC_txt; "pontis"; "pontis"; *)  //need the * as 4th parameter
C_TEXT:C284($CompletionStatus_txt)
//
$CompletionStatus_txt:="OK"
If (OK=1)
	
	ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : Connected to BrM database \n")
	// execute the SQL statements
	$BridgeCount_L:=Size of array:C274($AllCommands_atxt)
	$BridgeProgress_o:=ProgressNew("Exec SQL for "+String:C10($BridgeCount_L; "###,###")+\
		" NBI bridges "; $BridgeCount_L; True:C214; " Bridges"; 3)
	ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : Start execution of "+String:C10($BridgeCount_L; "###,###")+\
		" NBI SQL statements\n")
	C_TEXT:C284(SQL_txt)
	For ($bridge_L; 1; $BridgeCount_L)
		UpdateProgressNew($BridgeProgress_o; $bridge_L)
		SQL_TXT:=$AllCommands_atxt{$bridge_L}
		ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" # "+String:C10($bridge_L)+" : "+SQL_TXT+" \n")
		ON ERR CALL:C155("SQL_Error")
		SQLError_b:=False:C215
		
		SQL EXECUTE:C820(SQL_TXT+" ;")
		SQL CANCEL LOAD:C824
		
		ON ERR CALL:C155("")
		
		Case of 
			: (SQLError_b)
				//Error - exit loop
				$bridge_L:=$BridgeCount_L+1
				ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : SQL ERROR   : \n")
				C_TEXT:C284($sql_errors_txt)
				$sql_errors_txt:=ut_ArraysToText("\t"; ->SQLErrorNumbers_al; ->SQL_InternalCodes_atxt; ->SQL_InternalDescriptions_atxt)
				ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : "+$sql_errors_txt+"\n")
				$CompletionStatus_txt:="SQLERROR"
				
				SQLError_b:=False:C215
				
			: (Progress Stopped(OB Get:C1224($BridgeProgress_o; "progress"; Is longint:K8:6)))
				//abort loop
				$bridge_L:=$BridgeCount_L+1
				ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : Stopped by user\n")
				$CompletionStatus_txt:="USERABORT"
				
		End case 
		
	End for 
	
	Progress QUIT(OB Get:C1224($BridgeProgress_o; "progress"; Is longint:K8:6))
	ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : End execution of "+String:C10($BridgeCount_L; "###,###")+\
		" NBI SQL statements. Status = "+$CompletionStatus_txt+"\n")
	
	If ($CompletionStatus_txt="OK")
		//continue with non-NBI if we are still OK
		
		$BridgeCount_L:=Size of array:C274($AllNonNBICommands_atxt)
		$BridgeProgress_o:=ProgressNew("Exec SQL for "+String:C10($BridgeCount_L; "###,###")+\
			" NonNBI bridges "; $BridgeCount_L; True:C214; " Bridges"; 3)
		ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : Start execution of "+String:C10($BridgeCount_L; "###,###")+\
			" NonNBI SQL statements\n")
		C_TEXT:C284(SQL_txt)
		For ($bridge_L; 1; $BridgeCount_L)
			UpdateProgressNew($BridgeProgress_o; $bridge_L)
			SQL_TXT:=$AllNonNBICommands_atxt{$bridge_L}
			ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" # "+String:C10($bridge_L)+" : "+SQL_TXT+" \n")
			ON ERR CALL:C155("SQL_Error")
			SQLError_b:=False:C215
			
			SQL EXECUTE:C820(SQL_TXT+" ;")
			SQL CANCEL LOAD:C824
			
			ON ERR CALL:C155("")
			
			Case of 
				: (SQLError_b)
					//Error - exit loop
					$bridge_L:=$BridgeCount_L+1
					ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : SQL ERROR   : \n")
					C_TEXT:C284($sql_errors_txt)
					$sql_errors_txt:=ut_ArraysToText("\t"; ->SQLErrorNumbers_al; ->SQL_InternalCodes_atxt; ->SQL_InternalDescriptions_atxt)
					ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : "+$sql_errors_txt+"\n")
					$CompletionStatus_txt:="SQLERROR"
					
					SQLError_b:=False:C215
					
				: (Progress Stopped(OB Get:C1224($BridgeProgress_o; "progress"; Is longint:K8:6)))
					//abort loop
					$bridge_L:=$BridgeCount_L+1
					ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : Stopped by user\n")
					$CompletionStatus_txt:="USERABORT"
					
			End case 
			
		End for 
		
		Progress QUIT(OB Get:C1224($BridgeProgress_o; "progress"; Is longint:K8:6))
		ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : End execution of "+String:C10($BridgeCount_L; "###,###")+\
			" NonNBI SQL statements. Status = "+$CompletionStatus_txt+"\n")
		
	End if 
	
	SQL LOGOUT:C872
	
	ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : Logged out of BrM DB\n")
	
	
Else 
	$CompletionStatus_txt:="NOConnection"
	
	ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : Error connecting to the BrM ODBC DSN!\n")
	
End if 

//update the effective date unless there are errors

Case of 
	: ($CompletionStatus_txt="OK")
		CONFIRM:C162("Update the Last BrM NBI Update date to "+String:C10(Current date:C33(*))+"?"; "Update"; "Leave as "+String:C10($LastBrMUpdate_d))
		
		If (OK=1)
			ut_UpdateSysParameter("PON_LastBrMNBIUpdate"; String:C10(Current date:C33(*)))
		End if 
		
	: ($CompletionStatus_txt="SQLERROR")
		ALERT:C41("SQL ERROR encountered! See error description in the log file!")
		SHOW ON DISK:C922(MessageDefDir_txt+$LogFileName_txt+".txt"; *)
		
	: ($CompletionStatus_txt="USERABORT")
		ALERT:C41("User aborted the SQL update!")
		
	: ($CompletionStatus_txt="NOConnection")
		ALERT:C41("Could not connect to the BrM ODBC DSN")
		
End case 

ut_CloseMessage

//End PON_SendNBItoBrM