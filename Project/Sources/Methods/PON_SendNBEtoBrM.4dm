//%attributes = {"invisible":true}
//Method: PON_SendNBEtoBrM
//Description
// Send to BrM files prepared by method PON_CollectNBEforBrM
// Parameters
// 
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/12/19, 09:18:13
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

ut_SetMessageDir("BMStoBrMTransfers")
C_TEXT:C284($LogFileName_txt; $TimeStamp_txt)
$TimeStamp_txt:=ut_ReturnTimeStampFromDate(Current date:C33(*); Current time:C178(*))
$LogFileName_txt:="SendNBEtoBrM-"+$TimeStamp_txt
ut_StartMessage(2; $LogFileName_txt)

C_TEXT:C284($LastBrMNBIUpdate_txt; $BRM_ODBC_txt)
C_DATE:C307($LastBrMUpdate_d)
$LastBrMNBIUpdate_txt:=ut_GetSysParameter("PON_LastBrMNBEUpdate"; "07/05/2015")
$BRM_ODBC_txt:=ut_GetSysParameter("PON_BRMODBCName"; "BRM")

If (Date:C102($LastBrMNBIUpdate_txt)>!00-00-00!)
	$LastBrMUpdate_d:=Date:C102($LastBrMNBIUpdate_txt)
End if 


SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)

C_TEXT:C284($outputFolder_txt; $ProcessedFolder_txt; $timestamp_txt)  //folder where the grouped statement files will be created
$outputFolder_txt:=Select folder:C670("Select folder to process"; "")

ASSERT:C1129(OK=1; "You Canceled out of folder selection!")

$ProcessedFolder_txt:=$outputFolder_txt+"Processed"+Folder separator:K24:12
If (Test path name:C476($ProcessedFolder_txt)=Is a folder:K24:2)
Else 
	CREATE FOLDER:C475($ProcessedFolder_txt; *)
End if 
//extract the timestamp from the output folder name -t should be the last 12 chars 
$timestamp_txt:=Substring:C12($outputFolder_txt; Length:C16($outputFolder_txt)-12)
C_DATE:C307($NBEToBrMUpdate_d)
$NBEToBrMUpdate_d:=ut_ReturnDateFromTimeStamp($timestamp_txt)

C_DATE:C307(vDate; ACTDATE)  //vDate used in the date widget
ACTDATE:=$NBEToBrMUpdate_d
C_TEXT:C284(VTMESSAGE)
VTMESSAGE:="Confirm Date extracted from folder name\n"+$outputFolder_txt+" \nCancel will abort process!"

C_LONGINT:C283($dlog_L)
$dlog_L:=Open form window:C675("ChooseDate"; Movable form dialog box:K39:8)
DIALOG:C40("ChooseDate")
CLOSE WINDOW:C154($dlog_L)

If (OK=1)
	$NBEToBrMUpdate_d:=vDate
End if 

ASSERT:C1129((OK=1); "You Canceled date verification!")

C_OBJECT:C1216($NBIBridgeProgress_o)
C_OBJECT:C1216($sqlcommandprogress_o)
C_TEXT:C284($CompletionStatus_txt)
$CompletionStatus_txt:="OK"
//connect to BrM SQL
SQL LOGIN:C817("ODBC:"+$BRM_ODBC_txt; "pontis"; "pontis"; *)  //need the * as 4th parameter
If (OK=1)
	C_LONGINT:C283($Elem_L; $FileCount_L; $File_L; $NBEElemCount_L)
	ARRAY TEXT:C222($Files_atxt; 0)
	DOCUMENT LIST:C474($outputFolder_txt; $Files_atxt; Ignore invisible:K24:16)
	$FileCount_L:=Size of array:C274($Files_atxt)
	
	$NBIBridgeProgress_o:=ProgressNew("Executing SQL found in "+String:C10($FileCount_L)+" Files"; $FileCount_L; True:C214; " Files"; 3)
	C_TEXT:C284(SQL_txt; $SQLCommands_txt)
	
	For ($File_L; 1; $FileCount_L)
		
		UpdateProgressNew($NBIBridgeProgress_o; $File_L)
		
		$SQLCommands_txt:=Document to text:C1236($outputFolder_txt+$Files_atxt{$File_L})
		ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : Loaded commands from file "+$Files_atxt{$File_L}+" \n")
		
		ARRAY TEXT:C222($ElemInspCommands_atxt; 0)
		C_TEXT:C284($delim_txt)
		
		Case of 
			: (Position:C15("\r\n"; $SQLCommands_txt)>0)
				$delim_txt:="\r\n"
			: (Position:C15("\r"; $SQLCommands_txt)>0)
				$delim_txt:="\r"
			: (Position:C15("\n"; $SQLCommands_txt)>0)
				$delim_txt:="\n"
		End case 
		
		ut_TextToArray($SQLCommands_txt; ->$ElemInspCommands_atxt; $delim_txt)
		$NBEElemCount_L:=Size of array:C274($ElemInspCommands_atxt)
		ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : Extracted "+String:C10($NBEElemCount_L)+" SQL commands\n")
		
		//start the bar
		$sqlcommandprogress_o:=ProgressNew(""+String:C10($NBEElemCount_L)+" SQL cmds in "+$Files_atxt{$File_L}; $NBEElemCount_L; True:C214; " Commands"; 3)
		
		C_BOOLEAN:C305($FileProcessed_b)
		$FileProcessed_b:=True:C214
		For ($Elem_L; 1; $NBEElemCount_L)
			//update progress
			UpdateProgressNew($sqlcommandprogress_o; $Elem_L)
			
			SQL_TXT:=$ElemInspCommands_atxt{$Elem_L}
			ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : "+SQL_TXT+" \n")
			
			ON ERR CALL:C155("SQL_Error")
			SQLError_b:=False:C215
			
			SQL EXECUTE:C820(SQL_TXT+" ;")
			SQL CANCEL LOAD:C824
			
			ON ERR CALL:C155("")
			
			Case of 
				: (SQLError_b)
					//Error - exit all loops
					$Elem_L:=$NBEElemCount_L+1
					$File_L:=$FileCount_L+1
					ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : SQL ERROR   : \n")
					C_TEXT:C284($sql_errors_txt)
					$sql_errors_txt:=ut_ArraysToText("\t"; ->SQLErrorNumbers_al; ->SQL_InternalCodes_atxt; ->SQL_InternalDescriptions_atxt)
					ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+"  Errors : "+$sql_errors_txt+"\n")
					$CompletionStatus_txt:="SQLERROR"
					
					SQLError_b:=False:C215
					$FileProcessed_b:=False:C215
					
				: (Progress Stopped(OB Get:C1224($sqlcommandprogress_o; "progress"; Is longint:K8:6)))
					//abort loop
					$Elem_L:=$NBEElemCount_L+1
					$File_L:=$FileCount_L+1
					ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : Stopped by user\n")
					$CompletionStatus_txt:="USERABORT"
					$FileProcessed_b:=False:C215
					
				: (Progress Stopped(OB Get:C1224($NBIBridgeProgress_o; "progress"; Is longint:K8:6)))
					//abort loop
					$Elem_L:=$NBEElemCount_L+1
					$File_L:=$FileCount_L+1
					ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : Stopped by user\n")
					$CompletionStatus_txt:="USERABORT"
					$FileProcessed_b:=False:C215
					
			End case 
			
		End for   // end of elem sql command loop
		
		//quit progress
		Progress QUIT(OB Get:C1224($sqlcommandprogress_o; "progress"; Is longint:K8:6))
		
		If ($FileProcessed_b)
			//finished current file successfully - move it to the proc
			MOVE DOCUMENT:C540($outputFolder_txt+$Files_atxt{$File_L}; $ProcessedFolder_txt+$Files_atxt{$File_L})
			
		End if 
		
		If (Progress Stopped(OB Get:C1224($NBIBridgeProgress_o; "progress"; Is longint:K8:6)))
			//abort file loop
			$File_L:=$FileCount_L+1
			ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : Stopped by user\n")
			$CompletionStatus_txt:="USERABORT"
		End if 
		
	End for   // end of file processing loop
	
	SQL LOGOUT:C872
	ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : Logged out of BrM DB\n")
	
	Progress QUIT(OB Get:C1224($NBIBridgeProgress_o; "progress"; Is longint:K8:6))
	
Else 
	$CompletionStatus_txt:="NOConnection"
	ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : Error connecting to the BrM ODBC DSN!\n")
	
End if 

//update the effective date unless there are errors

Case of 
	: ($CompletionStatus_txt="OK")
		CONFIRM:C162("Update the Last BrM NBE Update date to "+String:C10($NBEToBrMUpdate_d)+"?"; "Update"; "Leave as "+String:C10($LastBrMUpdate_d))
		
		If (OK=1)
			ut_UpdateSysParameter("PON_LastBrMNBEUpdate"; String:C10($NBEToBrMUpdate_d))
		End if 
		
	: ($CompletionStatus_txt="ELEM39")
		ALERT:C41("Could not deal with Element 39 in some inspections! Search for text \"Element 39\" messages in the log file!")
		SHOW ON DISK:C922(MessageDefDir_txt+$LogFileName_txt+".txt"; *)
		
	: ($CompletionStatus_txt="SQLERROR")
		ALERT:C41("SQL ERROR encountered! See error description in the log file!")
		SHOW ON DISK:C922(MessageDefDir_txt+$LogFileName_txt+".txt"; *)
		
	: ($CompletionStatus_txt="USERABORT")
		ALERT:C41("User aborted the SQL update!")
		
	: ($CompletionStatus_txt="NOConnection")
		ALERT:C41("Could not connect to the BrM ODBC DSN")
		
End case 


ut_CloseMessage


//End PON_SendNBEtoBrM