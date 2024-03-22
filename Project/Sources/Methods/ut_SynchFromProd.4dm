//%attributes = {"invisible":true}
//Method: ut_SynchFromProd
//Description
//  ` Sync tables from production server to current db for the Preservation module
//  ` Uses db parameters PresProdIP and PresTablesToSynch
// Parameters
// ----------------------------------------------------
If (False:C215)
	//----------------------------------------------------
	//User name (OS): Charles Miller
	//Date and time: 05/28/13, 10:52:39
	//----------------------------------------------------
	//Mods_2013_05  `r003 ` 
	//Modified by: Charles Miller (5/28/13 10:52:45)
	// Modified by: Costas Manousakis-(Designer)-(7/29/13 21:41:24)
	Mods_2013_07
	//  `added output of errors.
	//  `re set the error after each table
	//  `do not Save record right after creating a new one before doing the update of fields
	// Modified by: Costas Manousakis-(Designer)-(7/31/13 14:14:49)
	Mods_2013_07
	//  `Renamed method to ut_SynchFromProd from ut_SynchFromProdForPreservation
End if 

C_TEXT:C284($IPAddress_txt; $Targetfolder_txt; $Temp_txt)

$IPAddress_txt:=ut_GetSysParameter("PresProdIP"; "146.243.135.242:19812")
$Temp_txt:=ut_GetSysParameter("PresTablesToSynch")

ARRAY TEXT:C222($Tables_atxt; 0)
C_LONGINT:C283($Loop_L; $HighestTableNumber_L)

ut_TextToArray($Temp_txt; ->$Tables_atxt; Char:C90(Carriage return:K15:38))
C_TEXT:C284($Timestamp_txt)

If (Size of array:C274($Tables_atxt)>0)
	$Targetfolder_txt:=ut_ReturnUserDocFolder("PreservationSynch")
	$HighestTableNumber_L:=Get last table number:C254
	$Timestamp_txt:=ut_ReturnTimeStampFromDate(Current date:C33(*); Current time:C178(*))
	$Targetfolder_txt:=$Targetfolder_txt+"PreservationSynch_"+$Timestamp_txt+".txt"
	ARRAY TEXT:C222($TableNames_atxt; 0)
	ARRAY LONGINT:C221($TableNumber_al; 0)
	ARRAY TEXT:C222($TableNames_atxt; $HighestTableNumber_L)
	ARRAY LONGINT:C221($TableNumber_al; $HighestTableNumber_L)
	C_TIME:C306($doc_tm)
	
	$doc_tm:=Create document:C266($Targetfolder_txt)
	SEND PACKET:C103($doc_tm; "Beginning Preservation Synch process at "+$Timestamp_txt+Char:C90(Carriage return:K15:38))
	CLOSE DOCUMENT:C267($doc_tm)
	C_LONGINT:C283(Count_l)
	C_TEXT:C284(SQLCount_txt; SQL_txt)
	
	
	For ($Loop_L; 1; $HighestTableNumber_L)
		If (Is table number valid:C999($Loop_L))
			$TableNames_atxt{$Loop_L}:=Table name:C256($Loop_L)
			$TableNumber_al{$Loop_L}:=$Loop_L
		End if 
		
	End for 
	
	C_POINTER:C301($Table_ptr; $Fld_pointer; $Variable_ptr)
	C_LONGINT:C283($FindPosition_L; $UniqueFldNumber_l; $InnerLoop_l; $TableNumber_L)
	C_TEXT:C284($TableName_txt; $Variable_txt; $SelectFields_txt; $UpdateFields_txt)
	
	COMPILER_forSQL
	vbOnScreenMessage:=False:C215
	vbToFileMessage:=False:C215
	ut_SQLConnect("Designer"; "caesar"; $IPAddress_txt)
	ut_InitFieldArray
	
	For ($Loop_L; 1; Size of array:C274($Tables_atxt))
		$doc_tm:=Append document:C265($Targetfolder_txt)
		SEND PACKET:C103($doc_tm; "Looking for table name "+$Tables_atxt{$Loop_L}+Char:C90(Carriage return:K15:38))
		CLOSE DOCUMENT:C267($doc_tm)
		$FindPosition_L:=Find in array:C230($TableNames_atxt; $Tables_atxt{$Loop_L})
		If ($FindPosition_L>0)
			ARRAY POINTER:C280(KeysToReset_aptr; 0)
			ARRAY LONGINT:C221(KeyIndextType_aL; 0)
			
			$TableNumber_L:=$TableNumber_al{$FindPosition_L}
			$Table_ptr:=Table:C252($TableNumber_L)
			
			$TableName_txt:=Table name:C256($TableNumber_l)
			SQLCount_txt:="SELECT Count(*) FROM ["+$TableName_txt+"] INTO :Count_l"
			Compiler_FieldVariables($TableNumber_l)
			clone_ClearFieldVariables($TableNumber_l)
			clone_ReturnKeyFldandVariable($TableNumber_l; ->$UniqueFldNumber_l; ->$Variable_txt; True:C214)
			$Timestamp_txt:=ut_ReturnTimeStampFromDate(Current date:C33(*); Current time:C178(*))
			
			If ($UniqueFldNumber_l=0)
				TRUNCATE TABLE:C1051($Table_ptr->)
				$doc_tm:=Append document:C265($Targetfolder_txt)
				SEND PACKET:C103($doc_tm; "Truncating table name "+$Tables_atxt{$Loop_L}+" at "+$Timestamp_txt+Char:C90(Carriage return:K15:38))
				CLOSE DOCUMENT:C267($doc_tm)
			Else 
				$Fld_pointer:=Field:C253($TableNumber_l; $UniqueFldNumber_l)
				$Variable_ptr:=Get pointer:C304($Variable_txt)
				$doc_tm:=Append document:C265($Targetfolder_txt)
				SEND PACKET:C103($doc_tm; "Updating table name "+$Tables_atxt{$Loop_L}+" at "+$Timestamp_txt+Char:C90(Carriage return:K15:38))
				CLOSE DOCUMENT:C267($doc_tm)
			End if 
			
			Begin SQL
				EXECUTE IMMEDIATE :SQLCount_txt;
			End SQL
			clone_CloneSetUpSelectInto($TableNumber_l; ->$SelectFields_txt; ->$UpdateFields_txt; False:C215)
			
			Offset_l:=1
			SQL_txt:="SELECT "+$SelectFields_txt+" FROM ["+$TableName_txt+"] LIMIT 1 OFFSET :Offset_l INTO "+$UpdateFields_txt
			
			Repeat 
				
				Compiler_FieldVariables($TableNumber_l)
				clone_ClearFieldVariables($TableNumber_l)
				ON ERR CALL:C155("SQL_Error")
				Begin SQL
					EXECUTE IMMEDIATE :SQL_txt;
				End SQL
				If (Not:C34(4DError_b)) & (Not:C34(SQLError_b))
					ON ERR CALL:C155("4D_Errors")
					If ($UniqueFldNumber_l=0)
						REDUCE SELECTION:C351($Table_ptr->; 0)
					Else 
						QUERY:C277($Table_ptr->; $Fld_pointer->=$Variable_ptr->)
					End if 
					If (Records in selection:C76($Table_ptr->)=1)
						If (ut_LoadRecord($Table_ptr; 1000))
						End if 
					Else 
						
						CREATE RECORD:C68($Table_ptr->)
						//SAVE RECORD($Table_ptr->)
					End if 
					clone_NewSQLUpdateLocalTable($TableNumber_l)
					
					SAVE RECORD:C53($Table_ptr->)
					UNLOAD RECORD:C212($Table_ptr->)
					Offset_l:=Offset_l+1
				End if 
				
			Until (Offset_l=Count_l) | (4DError_b) | (SQLError_b)
			$doc_tm:=Append document:C265($Targetfolder_txt)
			$Timestamp_txt:=ut_ReturnTimeStampFromDate(Current date:C33(*); Current time:C178(*))
			SEND PACKET:C103($doc_tm; "Completed process for  table name "+$Tables_atxt{$Loop_L}+" at "+$Timestamp_txt+Char:C90(Carriage return:K15:38))
			SEND PACKET:C103($doc_tm; "  Records retrieved "+String:C10(Offset_l)+"  - source count "+String:C10(Count_l)+" 4D Error "+f_Boolean2String(4DError_b; "YN")+" SQL Error "+f_Boolean2String(SQLError_b; "YN")+Char:C90(Carriage return:K15:38))
			
			If (SQLError_b | 4DError_b)
				C_LONGINT:C283($loop2_L)
				For ($loop2_L; 1; Size of array:C274(SQL_InternalDescriptions_atxt))
					SEND PACKET:C103($doc_tm; "   "+String:C10(SQLErrorNumbers_al{$loop2_L})+"  -  "+SQL_InternalCodes_atxt{$loop2_L}+"  -  "+SQL_InternalDescriptions_atxt{$loop2_L}+Char:C90(Carriage return:K15:38))
				End for 
				SEND PACKET:C103($doc_tm; Char:C90(Carriage return:K15:38)+"SQL statement:"+Char:C90(Carriage return:K15:38))
				SEND PACKET:C103($doc_tm; SQL_txt+Char:C90(Carriage return:K15:38))
				If ($UniqueFldNumber_l=0)
					SEND PACKET:C103($doc_tm; "No Unique field"+Char:C90(Carriage return:K15:38))
				Else 
					SEND PACKET:C103($doc_tm; "Unique field "+Field name:C257($Fld_pointer->)+" ; Var ;"+$Variable_txt+Char:C90(Carriage return:K15:38))
				End if 
				SEND PACKET:C103($doc_tm; Char:C90(Carriage return:K15:38))
				
			End if 
			
			CLOSE DOCUMENT:C267($doc_tm)
			For ($InnerLoop_l; 1; Size of array:C274(KeysToReset_aptr))
				SET INDEX:C344(KeysToReset_aptr{$InnerLoop_l}->; KeyIndextType_aL{$InnerLoop_l}; *)
			End for 
			
		End if 
		//Reset Errors for the next table
		SQLError_b:=False:C215
		4DError_b:=False:C215
		
	End for 
	$doc_tm:=Append document:C265($Targetfolder_txt)
	$Timestamp_txt:=ut_ReturnTimeStampFromDate(Current date:C33(*); Current time:C178(*))
	
	SEND PACKET:C103($doc_tm; "Completed Synch process at "+$Timestamp_txt+Char:C90(Carriage return:K15:38))
	CLOSE DOCUMENT:C267($doc_tm)
	ut_SQLLogout
End if 

//End ut_SynchFromProdForPreservation