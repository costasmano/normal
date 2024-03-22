//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_PRJRetrieveAdDate
// User name (OS): cjmiller
// Date and time: 05/05/06, 15:23:41
// ----------------------------------------------------
// Description
// Not called anyplace
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2007_CJM_v54  //r001 `11/13/07, 11:45:28`Make param code no more than 20 characters
	Mods_2009_07  //r003 `07/27/09, 10:50:28   `Fix errors when SQL calls fail
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	Mods_2019_06  //Modify sql server retrieves to not use ODBC plugin but native 4D SQL
	//Modified by: Chuck Miller (6/18/19 11:13:10)
End if 
C_TEXT:C284($EOL)
C_TIME:C306($SQLDocument_tm)
If (<>PL_LPlatfrm<3)
	$EOL:=Char:C90(Carriage return:K15:38)
Else 
	$EOL:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
End if 
ALL RECORDS:C47([PRJ_ProjectFile:117])
FIRST RECORD:C50([PRJ_ProjectFile:117])
C_LONGINT:C283($Loop_l)
C_TIME:C306($StartTime_tm; $RemainingTime_tm)
$StartTime_tm:=Current time:C178(*)
C_LONGINT:C283($Loop_l; $SizeOfArray_l; $NewRecords_l; $UpdatedRecords_l; $win)
$SizeOfArray_l:=Records in selection:C76([PRJ_ProjectFile:117])
$win:=Open window:C153(50; 50; 550; 250; 4; "Retrieving Ad Date")
C_TIME:C306($StartTime_tm; $RemainingTime_tm)
PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Begin Retrieve Ad Date  "+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178(*))+$Eol
C_LONGINT:C283($Counter_l)
$Counter_l:=0
For ($Loop_l; 1; Records in selection:C76([PRJ_ProjectFile:117]))
	GOTO XY:C161(5; 2)
	MESSAGE:C88("Retrieving "+String:C10($Loop_l)+" out of "+String:C10($SizeOfArray_l))
	GOTO XY:C161(5; 5)
	$RemainingTime_tm:=(($SizeOfArray_l/$Loop_l)-1)*(Current time:C178(*)-$StartTime_tm)
	MESSAGE:C88("Estimated time remaining is "+Time string:C180($RemainingTime_tm))
	GOTO XY:C161(5; 7)
	MESSAGE:C88("Elapsed time is "+Time string:C180(Current time:C178(*)-$StartTime_tm))
	
	If (SQL_Direct("sp_RTRVAdDtForFileNo"; "Built"))
		$Counter_l:=$Counter_l+1
		If (Size of array:C274(PRJFileAdDate_atxt)>0)
			If ([PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5#Date:C102(PRJFileAdDate_atxt{1}))
				ut_LoadRecord(->[PRJ_ProjectFile:117])
				[PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5:=Date:C102(PRJFileAdDate_atxt{1})
				SAVE RECORD:C53([PRJ_ProjectFile:117])
			End if 
		End if 
	Else 
		PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Call to sp_RTRVAdDtForFileNo Failed for "+"[PRJ_ProjectFile]PF_FileNumber_l "+String:C10([PRJ_ProjectFile:117]PF_FileNumber_l:3)+$Eol
		PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+SQL_ReturnErrorDescriptions+$eol
		$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
		SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
		CLOSE DOCUMENT:C267($SQLDocument_tm)
		PRJ_SQLRetrieveStats_txt:=""
		
	End if 
	NEXT RECORD:C51([PRJ_ProjectFile:117])
End for 

PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+String:C10($Counter_l)+" Project file records updated"+$eol
PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"End Retrieve Ad Date  "+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178(*))+$Eol
UNLOAD RECORD:C212([PRJ_ProjectFile:117])
CLOSE WINDOW:C154
//End ut_PRJRetrieveAdDate