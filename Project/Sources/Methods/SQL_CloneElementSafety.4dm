//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 01/17/12, 19:00:25
//----------------------------------------------------
//Method: SQL_CloneElementSafety
//Descriptionƒ
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_01  //r001
	//Modified by: Charles Miller (1/17/12 19:00:26)
	//Mods_2019_08  //Fixed error in following two clone methods and changed to use new progress bar component
	//Error was that the The did not use blob arrays and some clone directives where not defined
	//Modified by: Chuck Miller (8/22/19 13:13:49)
	Mods_2020_01  //Moved changed clone code for new datat file in to make arrays are used
	//Modified by: CJ (1/14/20 11:46:37)
	Mods_2020_01
	// This method is obsolete and can be removed it has been replaced by SQL_NewCloneElementSafety from BF
	
End if 
READ WRITE:C146(*)


TRUNCATE TABLE:C1051([ElementsSafety:29])
Compiler_FieldVariables
ut_InitFieldArray
C_BLOB:C604(BlobHoldUpdates_blb)
SET BLOB SIZE:C606(BlobHoldUpdates_blb; 0)
Compiler_clone
clone_IncludeUUIDS_B:=False:C215
clone_UseBlobArrays_B:=True:C214

ARRAY TEXT:C222(SQL_LimitNames_atxt; 0)
sql_FillLimitArrays

ARRAY TEXT:C222(clone_TablesWithUniqueKey_atxt; 0)
ARRAY POINTER:C280(clone_UniqueKeys_aptr; 0)
ARRAY POINTER:C280(clone_Array_aptr; 0)
ARRAY POINTER:C280(clone_Table_aPtr; 0)
ARRAY BOOLEAN:C223($HasPictureOrBlob_ab; 0)
C_TEXT:C284($Variable_txt)
C_LONGINT:C283($TableNumber_l; ->$UniqueFldNumber_l)
C_BOOLEAN:C305($HasPictureOrBlob_b)
For ($TableNumber_l; 1; Get last table number:C254)
	
	$HasPictureOrBlob_b:=clone_ReturnUniqueKeys($TableNumber_l; ->$UniqueFldNumber_l; ->$Variable_txt; True:C214)
	
	If ($UniqueFldNumber_l>0)
		APPEND TO ARRAY:C911(clone_Table_aPtr; Table:C252($TableNumber_l))
		APPEND TO ARRAY:C911(clone_TablesWithUniqueKey_atxt; Table name:C256($TableNumber_l))
		APPEND TO ARRAY:C911(clone_UniqueKeys_aptr; Field:C253($TableNumber_l; $UniqueFldNumber_l))
		APPEND TO ARRAY:C911(clone_Array_aptr; Get pointer:C304($Variable_txt))
		APPEND TO ARRAY:C911($HasPictureOrBlob_ab; $HasPictureOrBlob_b)
	End if 
End for 

C_BLOB:C604($1; $Blob_blb)
$Blob_blb:=$1
C_TEXT:C284($IPAddress_txt; $2)
$IPAddress_txt:=$2
READ WRITE:C146(*)
SQLError_b:=False:C215
4DError_b:=False:C215
SQLConnectionMade_b:=False:C215
ut_SQLConnect("Designer"; "caesar"; $IPAddress_txt)

C_BOOLEAN:C305($UpdateDisplay_b)

If (SQLConnectionMade_b)
	
	clone_CreateremoteMissingFields
	ARRAY LONGINT:C221($IDs_al; 0)
	C_LONGINT:C283($Offset_l; $TableNumber_l; $Win; $RecordCount_l; $Loop_l; $ArraySize_l)
	$Offset_l:=0
	BLOB TO VARIABLE:C533($Blob_blb; $IDs_al; $Offset_l)
	//[ElementsSafety]
	C_LONGINT:C283($ArraySize_l; $Loop_l; InspectionIDF_l)
	
	
	$TableNumber_l:=Table:C252(->[ElementsSafety:29])
	
	
	C_POINTER:C301($Table_ptr)
	$Table_ptr:=Table:C252($TableNumber_l)
	
	C_TEXT:C284($TableName_txt)
	$TableName_txt:="["+Table name:C256($TableNumber_l)+"]"
	
	ON ERR CALL:C155("4D_Errors")
	C_TEXT:C284($SelectFields_txt; $UpdateFields_txt; SQL_txt)
	C_LONGINT:C283(Count_l)
	clone_CloneSetUpSelectInto($TableNumber_l; ->$SelectFields_txt; ->$UpdateFields_txt; True:C214)
	sql_LIMIT_L:=500
	//SQL_SetSelectInto ($TableNumber_l;->$SelectFields_txt;->$UpdateFields_txt)
	
	If (False:C215)
		SQL_txt:="SELECT "+$SelectFields_txt+" FROM "+$TableName_txt  //" where InspID = :InspectionIDF_l LIMIT  "+String(sql_limit_L)+"  OFFSET :Offset_l INTO "+$UpdateFields_txt
		SQLCount_txt:="SELECT Count(*) FROM "+$TableName_txt  //+" where [ElementsSafety].InspID = :InspectionIDF_l into :Count_l"
	Else 
		SORT ARRAY:C229($IDs_al; >)
		C_LONGINT:C283(LastID_L)
		InspectionIDF_l:=$IDs_al{1}
		LastID_L:=$IDs_al{Size of array:C274($IDs_al)}
		
		SQL_txt:="SELECT "+$SelectFields_txt+" FROM "+$TableName_txt+" LIMIT "+String:C10(sql_limit_L)+"  OFFSET :Offset_l INTO "+$UpdateFields_txt+";"
		SQLCount_txt:="SELECT Count(*) FROM  "+$TableName_txt+"  into :Count_l;"  //+" where [ElementsSafety].InspID = :InspectionIDF_l into :Count_l"
		
	End if 
	//If (Application type#4D Server)
	//$win:=ut_OpenNewWindow (500;200;5;4;"Retrieving data for table "+$TableName_txt)
	//C_TIME($StartTime_tm;$RemainingTime_tm)
	//$StartTime_tm:=Current time
	//End if 
	
	$ArraySize_l:=Size of array:C274($IDs_al)
	C_TEXT:C284($SQL_Where_txt)
	C_TEXT:C284($In_txt)
	C_LONGINT:C283($InCount_L)
	$Loop_l:=1
	$ArraySize_l:=Size of array:C274($IDs_al)
	//Repeat 
	arbNew_l:=1
	arbOld_l:=0
	clone_UseBlobArrays_L:=1
	clone_UseBlobArrays_B:=True:C214
	
	If (False:C215)
		SQL_txt:="SELECT "+$SelectFields_txt+" FROM "+$TableName_txt  //" where InspID = :InspectionIDF_l LIMIT  "+String(sql_limit_L)+"  OFFSET :Offset_l INTO "+$UpdateFields_txt
		SQLCount_txt:="SELECT Count(*) FROM "+$TableName_txt  //+" where [ElementsSafety].InspID = :InspectionIDF_l into :Count_l"
		
		$SQL_Where_txt:=" where [ElementsSafety].InspID in (?) "
		C_BOOLEAN:C305($Complete_B)
		$InCount_L:=0
		$Complete_B:=False:C215
		Repeat 
			If ($InCount_L=0)
				$In_txt:=String:C10($IDs_al{$Loop_l+$InCount_L})
			Else 
				$In_txt:=$In_txt+", "+String:C10($IDs_al{$Loop_l+$InCount_L})
			End if 
			$InCount_L:=$InCount_L+1
			$Complete_B:=(($InCount_L+$Loop_l)>$ArraySize_l) | ($InCount_L>10)
			
		Until ($Complete_B)
		$SQL_Where_txt:=Replace string:C233($SQL_Where_txt; "?"; $In_txt)
		$Loop_l:=$Loop_l+11
		SQL_txt:=SQL_txt+$SQL_Where_txt+" LIMIT "+String:C10(sql_limit_L)+" OFFSET :Offset_l INTO "+$UpdateFields_txt
		
		SQLCount_txt:=SQLCount_txt+$SQL_Where_txt+" into :Count_l "
	End if 
	If (False:C215)
		C_TIME:C306($Doc_tm)
		$Doc_tm:=Create document:C266("")
		SEND PACKET:C103($Doc_tm; SQL_txt+Char:C90(13)+Char:C90(13))
		SEND PACKET:C103($Doc_tm; "========"+Char:C90(13))
		SEND PACKET:C103($Doc_tm; SQLCount_txt+Char:C90(13)+Char:C90(13))
		CLOSE DOCUMENT:C267($doc_tm)
		
	End if 
	TRUNCATE TABLE:C1051([ElementsSafety:29])
	ON ERR CALL:C155("SQL_Error")
	
	Begin SQL
		EXECUTE IMMEDIATE :SQLCount_txt;
	End SQL
	C_LONGINT:C283(Offset_l; $OldLimt_L; $OriginalSize_L)
	4DError_b:=False:C215
	SQLError_b:=False:C215
	C_BOOLEAN:C305($ArrayResized_B)
	Offset_l:=0
	C_LONGINT:C283($OldLimt_L; $OldOffset_L; $RemoveLoop_l)
	C_TEXT:C284($Name_txt)
	C_LONGINT:C283($State_l; $Time_L)
	$OldLimt_L:=SQL_Limit_L
	C_OBJECT:C1216($progressobj_o)
	If (Count_l>0)
		$progressobj_o:=ProgressNew("Cloning Inspection Related Data for "+$TableName_txt; Count_l; True:C214; ""; 3)
		
		Repeat 
			//GOTO XY(5;2)
			//MESSAGE("Updating "+String(Offset_l+1)+" out of "+String(Count_l))
			//GOTO XY(5;5)
			//$RemainingTime_tm:=((Count_l/Offset_l+1)-1)*(Current time(*)-$StartTime_tm)
			//MESSAGE("Estimated time remaining is "+Time string($RemainingTime_tm))
			//GOTO XY(5;7)
			//MESSAGE("Elapsed time is "+Time string(Current time(*)-$StartTime_tm))
			UpdateProgressNew($progressObj_o; Offset_l+1)
			clone_ClearFieldVariables($TableNumber_l)
			ON ERR CALL:C155("SQL_Error")
			$ArrayResized_B:=False:C215
			SET TEXT TO PASTEBOARD:C523(SQL_txt)
			
			Begin SQL
				EXECUTE IMMEDIATE :SQL_txt;
			End SQL
			
			$OldOffset_L:=Offset_l
			If (ut_fTestForSQLor4DError)
				ON ERR CALL:C155("4D_Errors")
				$OriginalSize_L:=Size of array:C274(v_29_004_aL)
				REDUCE SELECTION:C351([ElementsSafety:29]; 0)
				For ($RemoveLoop_l; Size of array:C274(v_29_004_aL); 1; -1)
					If (Find in array:C230($IDs_al; v_29_004_aL{$RemoveLoop_L})>0)
					Else 
						$ArrayResized_B:=True:C214
						sql_CloneRemoveElement($TableNumber_l; $RemoveLoop_l)
					End if 
					
				End for 
				SQL_Limit_L:=Size of array:C274(v_29_004_aL)
				If (Size of array:C274(v_29_004_aL)>0)
					Clone_ArrayToSelection($TableNumber_l)
				End if 
				SQL_Limit_L:=$OldLimt_L
				If ($ArrayResized_B)
					Offset_l:=$OldOffset_L+SQL_Limit_L
					If ($OriginalSize_L#SQL_Limit_L)
						
						Offset_l:=Count_L
					End if 
					
				End if 
			End if 
		Until (Offset_l=Count_l) | (4DError_b) | (SQLError_b)
	End if 
	
	UNLOAD RECORD:C212($Table_ptr->)
	
	C_TEXT:C284($Name1_txt)
	
	//Until ($Loop_l>=$ArraySize_l)
	//If (BLOB size(BlobHoldUpdates_blb)>0)
	//C_LONGINT($Progress_L)
	
	//$Progress_L:=Progress New 
	
	//clone_ProcessBlobs ($TableNumber_l;$Progress_L)
	
	//  //Progress QUIT ($Progress_L)
	//End if 
	CLOSE WINDOW:C154
	
	ut_SQLLogout
	Progress QUIT(OB Get:C1224($progressObj_o; "progress"))
End if 
//End SQL_CloneElemntSafety