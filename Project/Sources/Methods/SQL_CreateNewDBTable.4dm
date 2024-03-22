//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 11/23/10, 09:59:48
// ----------------------------------------------------
// Method: SQL_CreateNewDBTable
// Description
// 
//
// Parameters
// ----------------------------------------------------


// Modified by: Charles Miller (11/23/10)
If (False:C215)
	Mods_2020_03  // Fix compilert sytanx problems
End if 
clone_ClearFieldVariables

ut_InitFieldArray
C_LONGINT:C283($TableNumber_l; $1; Offset_l; Count_l)
C_TEXT:C284($2; $IPAddress_txt)
$IPAddress_txt:=$2
C_LONGINT:C283($CurrentProcess_l)
$CurrentProcess_l:=Current process:C322
APPEND TO ARRAY:C911(<>NewDBProcesses_al; $CurrentProcess_l)
<>Launched_b:=True:C214
$TableNumber_l:=$1


C_POINTER:C301($Table_ptr)
$Table_ptr:=Table:C252($TableNumber_l)

Compiler_SQL
C_TEXT:C284($TableName_txt)
$TableName_txt:="["+Table name:C256($TableNumber_l)+"]"
SQLError_b:=False:C215
4DError_b:=False:C215
SQLConnectionMade_b:=False:C215
C_BOOLEAN:C305($Complete_b)
$Complete_b:=False:C215
Repeat 
	ut_SQLConnect("Designer"; "caesar"; $IPAddress_txt)
	If (SQLConnectionMade_b)
		$Complete_b:=True:C214
	Else 
		DELAY PROCESS:C323(Current process:C322; 360)
	End if 
Until ($Complete_b)
C_LONGINT:C283($win)
If (SQLConnectionMade_b)
	C_TEXT:C284(SQL_TEXT; KeyValue_txt)
	If (True:C214)
		clone_CreateSQLLimits
		SQL_TEXT:=""
		KeyValue_txt:=""
		ARRAY LONGINT:C221(ProcessTableNumber_al; 0)
		ARRAY TEXT:C222(ProcessTableNames_atxt; 0)
		APPEND TO ARRAY:C911(ProcessTableNumber_al; $TableNumber_l)
		APPEND TO ARRAY:C911(ProcessTableNames_atxt; Table name:C256($TableNumber_l))
		APPEND TO ARRAY:C911(RemoteCustomQuery_atxt; "")
		ARRAY TEXT:C222(RemoteKeyName_atxt; 0)
		ARRAY TEXT:C222(RemoteKeyName_atxt; 1)
		C_LONGINT:C283($UniqueFldNumber_l)
		C_LONGINT:C283(rbUpdate_l)
		C_BOOLEAN:C305(clone_IncludeUUIDS_B)
		clone_IncludeUUIDS_B:=False:C215
		C_TEXT:C284($Variable_txt)
		C_BOOLEAN:C305($Reindex_b)
		ARRAY TEXT:C222(RemoteQueryType_atxt; 0)
		ARRAY TEXT:C222(RemoteKey_atxt; 0)
		ARRAY TEXT:C222(RemoteQueryType_atxt; 1)
		ARRAY TEXT:C222(RemoteKey_atxt; 1)
		rbUpdate_l:=0
		clone_ReturnKeyFldandVariable($TableNumber_l; ->$UniqueFldNumber_l; ->$Variable_txt; $Reindex_b)
		
		If ($UniqueFldNumber_l>0)
			RemoteKeyName_atxt{1}:=Field name:C257($TableNumber_l; $UniqueFldNumber_l)
		End if 
		clone_BuildFieldDropDown(1)
		
		clone_Table
		
	Else 
		C_TEXT:C284($SelectFields_txt; $UpdateFields_txt; SQL_txt)
		If (Application type:C494#4D Server:K5:6)
			$win:=ut_OpenNewWindow(500; 200; 5; 4; "Retrieving data for table "+$TableName_txt)
		End if 
		clone_CloneSetUpSelectInto($TableNumber_l; ->$SelectFields_txt; ->$UpdateFields_txt; True:C214)
		
		C_LONGINT:C283(Offset_l; Count_l)
		
		C_BOOLEAN:C305($Complete_b)
		
		//Records in table($table_ptr->)
		ON ERR CALL:C155("SQL_Error")
		SQL_txt:="SELECT Count(*) FROM "+$TableName_txt+" INTO :Count_l ;"
		Begin SQL
			EXECUTE IMMEDIATE :SQL_txt;
		End SQL
		ON ERR CALL:C155("4D_Errors")
		SQL_txt:="SELECT "+$SelectFields_txt+" FROM "+$TableName_txt+" LIMIT 1 OFFSET :Offset_l INTO "+$UpdateFields_txt+";"
		If (Application type:C494#4D Server:K5:6)
			C_TIME:C306($StartTime_tm; $RemainingTime_tm)
			$StartTime_tm:=Current time:C178
		End if 
		Offset_l:=0
		If (Count_l>0)
			Repeat 
				C_BOOLEAN:C305($UpdateDisplay_b)
				$UpdateDisplay_b:=False:C215
				If (Application type:C494#4D Server:K5:6)
					Case of 
						: (Offset_l=1)
							$UpdateDisplay_b:=True:C214
						: (Offset_l+100>=Count_l)
							$UpdateDisplay_b:=True:C214
						: (Mod:C98(Offset_l; 100)=0)
							$UpdateDisplay_b:=True:C214
					End case 
					If ($UpdateDisplay_b)
						GOTO XY:C161(5; 2)
						MESSAGE:C88("Updating "+String:C10(Offset_l+1)+" out of "+String:C10(Count_l))
						GOTO XY:C161(5; 5)
						$RemainingTime_tm:=((Count_l/(Offset_l+1))-1)*(Current time:C178(*)-$StartTime_tm)
						MESSAGE:C88("Estimated time remaining is "+Time string:C180($RemainingTime_tm))
						GOTO XY:C161(5; 7)
						MESSAGE:C88("Elapsed time is "+Time string:C180(Current time:C178(*)-$StartTime_tm))
					End if 
				End if 
				
				ON ERR CALL:C155("SQL_Error")
				Begin SQL
					EXECUTE IMMEDIATE :SQL_txt;
				End SQL
				ON ERR CALL:C155("4D_Errors")
				If (Not:C34(SQLError_b))
					CREATE RECORD:C68($Table_ptr->)
					
					clone_NewSQLUpdateLocalTable($TableNumber_l)
					
					SAVE RECORD:C53($Table_ptr->)
					Offset_l:=Offset_l+1
				End if 
				
			Until (Offset_l=Count_l) | (SQLError_b) | (4DError_b)
			
			UNLOAD RECORD:C212($Table_ptr->)
			
		End if 
		ut_SQLLogout
	End if 
	If (SQLError_b) | (4DError_b) | (Not:C34(SQLConnectionMade_b))
		C_TIME:C306($doc)
		$doc:=Create document:C266($TableName_txt)
		C_LONGINT:C283($Loop_l)
		SEND PACKET:C103($Doc; "Errors occurred in processing table "+$TableName_txt)
		SEND PACKET:C103($doc; "CONNECT STATUS "+f_Boolean2String(SQLConnectionMade_b; "YN")+Char:C90(Carriage return:K15:38))
		SEND PACKET:C103($doc; "SQL Error "+f_Boolean2String(SQLError_b; "YN")+" 4D Error "+f_Boolean2String(4DError_b; "YN")+Char:C90(Carriage return:K15:38))
		SEND PACKET:C103($doc; String:C10(Offset_l)+" out of "+String:C10(Count_l)+" retrieved "+Char:C90(Carriage return:K15:38))
		
		SEND PACKET:C103($Doc; "SQL Error #"+Char:C90(Tab:K15:37)+"Internal #"+Char:C90(Tab:K15:37)+"Desc"+Char:C90(Carriage return:K15:38))
		For ($Loop_l; 1; Size of array:C274(SQLErrorNumbers_al))
			SEND PACKET:C103($Doc; String:C10(SQLErrorNumbers_al{$Loop_l})+Char:C90(Tab:K15:37))
			SEND PACKET:C103($Doc; SQL_InternalCodes_atxt{$Loop_l}+Char:C90(Tab:K15:37))
			SEND PACKET:C103($Doc; SQL_InternalDescriptions_atxt{$Loop_l}+Char:C90(Carriage return:K15:38))
			
		End for 
		SEND PACKET:C103($Doc; "The sql follows:"+Char:C90(Carriage return:K15:38)+SQL_txt+Char:C90(Carriage return:K15:38))
		CLOSE DOCUMENT:C267($doc)
		
	End if 
	CLOSE WINDOW:C154
End if 
Count_l:=Find in array:C230(<>NewDBProcesses_al; $CurrentProcess_l)
<>NewDBProcesses_al{Count_l}:=-999


//End method SQL_CreateNewDBTable
