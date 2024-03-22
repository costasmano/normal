//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 01/17/12, 19:00:25
//----------------------------------------------------
//Method: SQL_ClonePONELEMINSP
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_01  //r001
	//Modified by: Charles Miller (1/17/12 19:00:26)
	//Unused - can or shoukld we delete this
End if 
Compiler_FieldVariables
ut_InitFieldArray
C_BLOB:C604($1; $Blob_blb)
$Blob_blb:=$1
C_TEXT:C284($IPAddress_txt; $2)
$IPAddress_txt:=$2
C_BOOLEAN:C305($HasPicture_b)
C_LONGINT:C283($UniqueFldNumber_l)
C_TEXT:C284($Variable_txt)

READ WRITE:C146(*)
SQLError_b:=False:C215
4DError_b:=False:C215
SQLConnectionMade_b:=False:C215
ut_SQLConnect("Designer"; "caesar"; $IPAddress_txt)
C_LONGINT:C283(SQL_Limit_L; Offset_l)

C_BLOB:C604(BlobHoldUpdates_blb)

ARRAY TEXT:C222(clone_TablesWithUniqueKey_atxt; 0)
ARRAY POINTER:C280(clone_UniqueKeys_aptr; 0)
ARRAY POINTER:C280(clone_Array_aptr; 0)
ARRAY POINTER:C280(clone_Table_aPtr; 0)
ARRAY BOOLEAN:C223($HasPictureOrBlob_ab; 0)



C_BOOLEAN:C305($UpdateDisplay_b; clone_UseBlobArrays_B; clone_IncludeUUIDS_B)
clone_UseBlobArrays_B:=False:C215
clone_IncludeUUIDS_B:=False:C215
clone_CreateSQLLimits

ARRAY LONGINT:C221(clone_PrimaryKeyTable_aL; 0)
ARRAY LONGINT:C221(clone_PrimaryField_aL; 0)
C_LONGINT:C283($Primary_key_field_id_L; $TableLoop_L)
For ($TableLoop_L; 1; Get last table number:C254)
	If (Is table number valid:C999($TableLoop_L))
		$Primary_key_field_id_L:=clone_ReturnUUIDPrimaryKey($TableLoop_L)
		APPEND TO ARRAY:C911(clone_PrimaryKeyTable_aL; $TableLoop_L)
		APPEND TO ARRAY:C911(clone_PrimaryField_aL; $Primary_key_field_id_L)
		$HasPicture_b:=clone_ReturnUniqueKeys($TableLoop_L; ->$UniqueFldNumber_l; ->$Variable_txt; True:C214)
		If ($UniqueFldNumber_l>0)
			APPEND TO ARRAY:C911(clone_Table_aPtr; Table:C252($TableLoop_L))
			APPEND TO ARRAY:C911(clone_TablesWithUniqueKey_atxt; Table name:C256($TableLoop_L))
			APPEND TO ARRAY:C911(clone_UniqueKeys_aptr; Field:C253($TableLoop_L; $UniqueFldNumber_l))
			APPEND TO ARRAY:C911(clone_Array_aptr; Get pointer:C304($Variable_txt))
			APPEND TO ARRAY:C911($HasPictureOrBlob_ab; $HasPicture_b)
		End if 
	End if 
	
End for 

If (SQLConnectionMade_b)
	SET INDEX:C344([PON_ELEM_INSP:179]ELEM_KEY:3; False:C215)
	SET INDEX:C344([PON_ELEM_INSP:179]ENVKEY:5; False:C215)
	SET INDEX:C344([PON_ELEM_INSP:179]INSPID:21; False:C215)
	SET INDEX:C344([PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19; False:C215)
	SET INDEX:C344([PON_ELEM_INSP:179]ELEM_PARENTID:27; False:C215)
	
	ARRAY LONGINT:C221($IDs_al; 0)
	C_LONGINT:C283($Offset_l; $TableNumber_l; $Win; $RecordCount_l; $Loop_l; $ArraySize_l)
	$Offset_l:=0
	BLOB TO VARIABLE:C533($Blob_blb; $IDs_al; $Offset_l)
	//[ElementsSafety]
	C_LONGINT:C283($ArraySize_l; $Loop_l; InspectionIDF_l)
	
	
	$TableNumber_l:=Table:C252(->[PON_ELEM_INSP:179])
	
	
	C_POINTER:C301($Table_ptr)
	$Table_ptr:=Table:C252($TableNumber_l)
	
	C_TEXT:C284($TableName_txt)
	$TableName_txt:="["+Table name:C256($TableNumber_l)+"]"
	
	ON ERR CALL:C155("4D_Errors")
	C_TEXT:C284($SelectFields_txt; $UpdateFields_txt; SQL_txt)
	C_LONGINT:C283(Count_l)
	clone_CloneSetUpSelectInto($TableNumber_l; ->$SelectFields_txt; ->$UpdateFields_txt; True:C214)
	
	$SelectFields_txt:="PE."+$SelectFields_txt
	$SelectFields_txt:=Replace string:C233($SelectFields_txt; ","; ", PE.")
	SQL_txt:="SELECT "+$SelectFields_txt+" FROM "+$TableName_txt+"PE where PE.InspID = :InspectionIDF_l LIMIT "+String:C10(SQL_Limit_L)+" OFFSET :Offset_l INTO "+$UpdateFields_txt
	SQLCount_txt:="SELECT Count(*) FROM "+$TableName_txt+" where [PON_ELEM_INSP].[INSPID] = :InspectionIDF_l into :Count_l"
	
	If (Application type:C494#4D Server:K5:6)
		$win:=ut_OpenNewWindow(500; 200; 5; 4; "Retrieving data for table "+$TableName_txt)
		C_TIME:C306($StartTime_tm; $RemainingTime_tm)
		$StartTime_tm:=Current time:C178
	End if 
	
	$ArraySize_l:=Size of array:C274($IDs_al)
	
	For ($Loop_l; 1; $ArraySize_l)
		ON ERR CALL:C155("SQL_Error")
		If (Application type:C494#4D Server:K5:6)
			$UpdateDisplay_b:=False:C215
			Case of 
				: ($Loop_l=1)
					$UpdateDisplay_b:=True:C214
				: (Mod:C98($Loop_l; 100)=0)
					$UpdateDisplay_b:=True:C214
				: ($Loop_l+100>=$ArraySize_l)
					$UpdateDisplay_b:=True:C214
			End case 
			If ($UpdateDisplay_b)
				GOTO XY:C161(5; 2)
				MESSAGE:C88("Updating "+String:C10($Loop_l)+" out of "+String:C10($ArraySize_l))
				GOTO XY:C161(5; 5)
				$RemainingTime_tm:=(($ArraySize_l/$Loop_l)-1)*(Current time:C178(*)-$StartTime_tm)
				MESSAGE:C88("Estimated time remaining is "+Time string:C180($RemainingTime_tm))
				GOTO XY:C161(5; 7)
				MESSAGE:C88("Elapsed time is "+Time string:C180(Current time:C178(*)-$StartTime_tm))
			End if 
		End if 
		InspectionIDF_l:=$IDs_al{$Loop_l}
		Begin SQL
			EXECUTE IMMEDIATE :SQLCount_txt;
		End SQL
		C_POINTER:C301($Table_ptr)
		$Table_ptr:=Table:C252($TableNumber_l)
		Offset_l:=0
		If (Count_l>0)
			Repeat 
				
				clone_ClearFieldVariables($TableNumber_l)
				ON ERR CALL:C155("SQL_Error")
				Begin SQL
					EXECUTE IMMEDIATE :SQL_txt;
				End SQL
				If (ut_fTestForSQLor4DError)
					ON ERR CALL:C155("4D_Errors")
					REDUCE SELECTION:C351($Table_ptr->; 0)
					Clone_ArrayToSelection($TableNumber_l)
					
					//SET QUERY DESTINATION(Into variable;$RecordCount_l)
					//QUERY([ElementsSafety];[ElementsSafety]ElmSafetyID=v_29_007_l)
					//SET QUERY DESTINATION(Into current selection)
					//If ($RecordCount_l=0)
					
					//CREATE RECORD($Table_ptr->)
					//clone_NewSQLUpdateLocalTable ($TableNumber_l)
					
					//SAVE RECORD($Table_ptr->)
					//End if 
					//Offset_l:=Offset_l+1
				End if 
				
			Until (Offset_l=Count_l) | (4DError_b) | (SQLError_b)
		End if 
		
		UNLOAD RECORD:C212($Table_ptr->)
		
	End for 
	
	SET INDEX:C344([PON_ELEM_INSP:179]ELEM_KEY:3; 1)
	SET INDEX:C344([PON_ELEM_INSP:179]ENVKEY:5; 3)
	SET INDEX:C344([PON_ELEM_INSP:179]INSPID:21; 1)
	SET INDEX:C344([PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19; 1)
	SET INDEX:C344([PON_ELEM_INSP:179]ELEM_PARENTID:27; 1)
	
	CLOSE WINDOW:C154
	ut_SQLLogout
End if 
//End SQL_ClonePONELEMINSP