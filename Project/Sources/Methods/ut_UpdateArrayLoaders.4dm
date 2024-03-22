//%attributes = {"invisible":true}
// Method: ut_UpdateArrayLoaders
// Description
// update the stored arrays used to speed up searches/lookups
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/08/06, 10:05:05
	// ----------------------------------------------------
	// Modified by: Costas Manousakis-(Administrator)-(1/4/13 14:12:19)
	Mods_2013_01
	//  `Added  ON ERR  CALL to catch erros in individual loaders
	// Modified by: Costas Manousakis-(Designer)-(9/3/20 10:22:20)
	Mods_2020_09_bug
	//  `change the message folder name to include the server IP and port number
	// Modified by: Costas Manousakis-(Designer)-(9/23/20 13:38:40)
	Mods_2020_09_bug
	//  `retrieve the next run timestamp and log it in the messages file
End if 

Startup_PL
C_OBJECT:C1216($serverinfo_o)
$serverinfo_o:=SYSUTIL_GetServerInfo
C_TEXT:C284($messageDir_txt)
$messageDir_txt:="DailyUpdates_"+Replace string:C233(OB Get:C1224($serverinfo_o; "ServerIP"; Is text:K8:3); "."; "_")+"_"+OB Get:C1224($serverinfo_o; "ServerPort"; Is text:K8:3)
ut_SetMessageDir($messageDir_txt)
ut_StartMessage(2; "NewLoaderFiles")
C_BOOLEAN:C305(4DError_b)
C_LONGINT:C283($loop_L)

ON ERR CALL:C155("4D_Errors")
4DError_b:=False:C215
ut_Message("Pers Arrays "+String:C10(Current time:C178(*))+Char:C90(13))
ut_PutPersArraysIntoBlob
If (4DError_b)
	ut_Message("Error in Pers Arrays "+String:C10(Current time:C178(*))+Char:C90(13))
	For ($loop_L; 1; Size of array:C274(SQLErrorNumbers_al))
		ut_Message("ErrNo: "+String:C10(SQLErrorNumbers_al{$loop_L})+" ErrCode: "+SQL_InternalCodes_atxt{$loop_L}+" ErrDesc: "+SQL_InternalDescriptions_atxt{$loop_L}+Char:C90(13))
	End for 
End if 

4DError_b:=False:C215
ut_Message("BMS Arrays "+String:C10(Current time:C178(*))+Char:C90(13))
ut_PutBMSArraysToDoc
If (4DError_b)
	ut_Message("Error in BMS Arrays "+String:C10(Current time:C178(*))+Char:C90(13))
	For ($loop_L; 1; Size of array:C274(SQLErrorNumbers_al))
		ut_Message("ErrNo: "+String:C10(SQLErrorNumbers_al{$loop_L})+" ErrCode: "+SQL_InternalCodes_atxt{$loop_L}+" ErrDesc: "+SQL_InternalDescriptions_atxt{$loop_L}+Char:C90(13))
	End for 
End if 
4DError_b:=False:C215
ut_Message("Field Arrays "+String:C10(Current time:C178(*))+Char:C90(13))
ut_PutFieldDescriptionIntoBlob
If (4DError_b)
	ut_Message("Error in Field Arrays "+String:C10(Current time:C178(*))+Char:C90(13))
	For ($loop_L; 1; Size of array:C274(SQLErrorNumbers_al))
		ut_Message("ErrNo: "+String:C10(SQLErrorNumbers_al{$loop_L})+" ErrCode: "+SQL_InternalCodes_atxt{$loop_L}+" ErrDesc: "+SQL_InternalDescriptions_atxt{$loop_L}+Char:C90(13))
	End for 
End if 
4DError_b:=False:C215
ut_Message("Table Arrays "+String:C10(Current time:C178(*))+Char:C90(13))
ut_PutTableArrToDoc
If (4DError_b)
	ut_Message("Error in Table Arrays "+String:C10(Current time:C178(*))+Char:C90(13))
	For ($loop_L; 1; Size of array:C274(SQLErrorNumbers_al))
		ut_Message("ErrNo: "+String:C10(SQLErrorNumbers_al{$loop_L})+" ErrCode: "+SQL_InternalCodes_atxt{$loop_L}+" ErrDesc: "+SQL_InternalDescriptions_atxt{$loop_L}+Char:C90(13))
	End for 
End if 
4DError_b:=False:C215
ut_Message("Town Arrays "+String:C10(Current time:C178(*))+Char:C90(13))
ut_PutTWNDATAtoDoc
If (4DError_b)
	ut_Message("Error in Town Arrays "+String:C10(Current time:C178(*))+Char:C90(13))
	For ($loop_L; 1; Size of array:C274(SQLErrorNumbers_al))
		ut_Message("ErrNo: "+String:C10(SQLErrorNumbers_al{$loop_L})+" ErrCode: "+SQL_InternalCodes_atxt{$loop_L}+" ErrDesc: "+SQL_InternalDescriptions_atxt{$loop_L}+Char:C90(13))
	End for 
End if 
4DError_b:=False:C215
ut_Message("UIGV Arrays "+String:C10(Current time:C178(*))+Char:C90(13))
ut_PutUIGVArraysToDoc
If (4DError_b)
	ut_Message("Error in UIGV Arrays "+String:C10(Current time:C178(*))+Char:C90(13))
	For ($loop_L; 1; Size of array:C274(SQLErrorNumbers_al))
		ut_Message("ErrNo: "+String:C10(SQLErrorNumbers_al{$loop_L})+" ErrCode: "+SQL_InternalCodes_atxt{$loop_L}+" ErrDesc: "+SQL_InternalDescriptions_atxt{$loop_L}+Char:C90(13))
	End for 
End if 

ON ERR CALL:C155("")

ut_Message("Saving next run time stamp "+String:C10(Current time:C178(*))+Char:C90(13))
ut_SetNextRunTimeStamp("Server_UpdateArrayLoaders")
C_TEXT:C284($nextTimeStamp_s)
Begin SQL
	select [ServerProcesses].[NextRunTimeStamp_s]
	from [ServerProcesses]
	where [ServerProcesses].[ProcessName_s] = 'Server_UpdateArrayLoaders'
	into :$nextTimeStamp_s ;
End SQL
ut_Message("Next run timestamp was set to "+$nextTimeStamp_s+Char:C90(13))

ut_CloseMessage
ut_SetMessageDir("")