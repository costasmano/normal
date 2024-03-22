//%attributes = {"invisible":true}
//Method: SQL_ControlClone
//Description
//This method will create the following sets for the passed in district
//[Inspections]

// Parameters
// $1 : $Item2District 
// ----------------------------------------------------
If (False:C215)
	
	//----------------------------------------------------
	//User name (OS): Charles Miller
	//Date and time: 12/02/10, 12:17:59
	//----------------------------------------------------
	//Ugrade to v11
	//Modified by: Charles Miller (12/2/10 12:18:00)
	//Modify how (Not(4DError_b)) and (Not(SQLError_b)) handled replace with (ut_fTestForSQLor4DError)
	//Modified by: Charles Miller (11/4/11 11:19:05)
	Mods_2012_01  //r001 `Add ode to make sure we do not quit until secondary process is completed.
	//Modified by: Charles Miller (1/17/12 10:35:29)
	Compiler_clone
	Mods_2020_01  //Modified to use clone_CreateSQLLimits to gill limit arrays  from BF
	//Modified by: CJ (1/21/20 11:11:11)
	// Modified by: Costas Manousakis-(Designer)-(2021-11-24T00:00:00 18:08:05)
	Mods_2021_11_bug
	//  `if $1 is a wildcard , ie search all districts, adjust the search in personnel too.
	// Modified by: Costas Manousakis-(Designer)-(2023-04-07 16:18:39)
	Mods_2023_04
	//  `Remove IDLE after Delay process
End if 
Compiler_FieldVariables
ut_InitFieldArray
C_BOOLEAN:C305($HasPicture_b)
C_LONGINT:C283($UniqueFldNumber_l; $win; $TableNumber_l; $Inspcount_L; $ElementSafetyCount_L)

C_TEXT:C284($IPAddress_txt; $Variable_txt)

$IPAddress_txt:=SQL_TestConnection

If ($IPAddress_txt="")
	ALERT:C41("Clone cancelled")
Else 
	C_TIME:C306($Beg_tm)
	$Beg_tm:=Current time:C178
	C_TEXT:C284($1; $District_txt)
	
	$District_txt:=$1
	C_TEXT:C284($TableName_txt)
	C_BLOB:C604(BlobHoldUpdates_blb)
	
	ARRAY TEXT:C222(clone_TablesWithUniqueKey_atxt; 0)
	ARRAY POINTER:C280(clone_UniqueKeys_aptr; 0)
	ARRAY POINTER:C280(clone_Array_aptr; 0)
	ARRAY POINTER:C280(clone_Table_aPtr; 0)
	ARRAY BOOLEAN:C223($HasPictureOrBlob_ab; 0)
	
	C_BLOB:C604(v_29_023_blb)
	
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
	
	
	C_TEXT:C284($Division_s; $InspResp_txt)  // old C _ STRING length 4
	
	If (Position:C15("@"; $District_txt)>0)
		//There is a wildcard in the district - use wildcard for personnel
		$Division_s:="044@"
		$InspResp_txt:="DIST@"
	Else 
		$Division_s:="044"+String:C10(Num:C11($District_txt))
		$InspResp_txt:="DIST"+String:C10(Num:C11($District_txt))
	End if 
	
	SET QUERY DESTINATION:C396(Into set:K19:2; "InvPhotSet")
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]Item2:60=$District_txt; *)
	QUERY:C277([Bridge MHD NBIS:1];  | ; [Bridge MHD NBIS:1]InspResp:173=$InspResp_txt)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	USE SET:C118("InvPhotSet")
	ARRAY TEXT:C222($Bins_as; 0)  // old _ O _ARRAY STRING length 3
	C_LONGINT:C283($RecordCount_l)
	$RecordCount_l:=Records in selection:C76([Bridge MHD NBIS:1])
	ARRAY TEXT:C222($Bins_as; $RecordCount_l)  // old _ O _ARRAY STRING length 3
	
	SELECTION RANGE TO ARRAY:C368(1; $RecordCount_l; [Bridge MHD NBIS:1]BIN:3; $Bins_as)
	
	SET QUERY DESTINATION:C396(Into set:K19:2; "StartSet")
	QUERY WITH ARRAY:C644([Inspections:27]BIN:1; $Bins_as)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	QUERY:C277([Personnel:42]; [Personnel:42]Division No:7=$Division_s)
	ARRAY INTEGER:C220($PersonID_ai; 0)
	ARRAY INTEGER:C220($PersonID_ai; Records in selection:C76([Personnel:42]))
	
	SELECTION RANGE TO ARRAY:C368(1; Records in selection:C76([Personnel:42]); [Personnel:42]Person ID:1; $PersonID_ai)
	SET QUERY DESTINATION:C396(Into set:K19:2; "TeamLeaderSet")
	QUERY WITH ARRAY:C644([Inspections:27]TeamLeader:4; $PersonID_ai)
	CREATE EMPTY SET:C140([Inspections:27]; "InspectionSet")
	
	UNION:C120("StartSet"; "TeamLeaderSet"; "InspectionSet")
	
	SET QUERY DESTINATION:C396(Into set:K19:2; "StartSet")
	QUERY:C277([Inspections:27]; [Inspections:27]Insp Type:6="DV@")
	
	UNION:C120("StartSet"; "InspectionSet"; "InspectionSet")
	
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	//[Combined Inspections]
	USE SET:C118("InspectionSet")
	$RecordCount_l:=Records in selection:C76([Inspections:27])
	ARRAY LONGINT:C221($IDs_al; 0)
	ARRAY LONGINT:C221($IDs_al; $RecordCount_l)
	SELECTION RANGE TO ARRAY:C368(1; $RecordCount_l; [Inspections:27]InspID:2; $IDs_al)
	SELECTION RANGE TO ARRAY:C368(1; $RecordCount_l; [Inspections:27]BIN:1; $Bins_as)
	SET QUERY DESTINATION:C396(Into set:K19:2; "INSPBinSet")
	QUERY WITH ARRAY:C644([Bridge MHD NBIS:1]BIN:3; $Bins_as)
	
	SET QUERY DESTINATION:C396(Into set:K19:2; "CombinedSet")
	QUERY WITH ARRAY:C644([Combined Inspections:90]NBISInspID:2; $IDs_al)
	
	
	USE SET:C118("CombinedSet")
	$RecordCount_l:=Records in selection:C76([Combined Inspections:90])
	ARRAY LONGINT:C221($IDs_al; 0)
	ARRAY LONGINT:C221($IDs_al; $RecordCount_l)
	SELECTION RANGE TO ARRAY:C368(1; $RecordCount_l; [Combined Inspections:90]BMSInspID:3; $IDs_al)
	
	SET QUERY DESTINATION:C396(Into set:K19:2; "BMSSet")
	//[BMS Inspections]
	QUERY WITH ARRAY:C644([BMS Inspections:44]Inspection ID:1; $IDs_al)
	
	SET BLOB SIZE:C606(Send_BLB; 0)
	USE SET:C118("InspectionSet")
	$RecordCount_l:=Records in selection:C76([Inspections:27])
	ARRAY LONGINT:C221($IDs_al; 0)
	ARRAY LONGINT:C221($IDs_al; $RecordCount_l)
	SELECTION RANGE TO ARRAY:C368(1; $RecordCount_l; [Inspections:27]InspID:2; $IDs_al)
	C_LONGINT:C283($ProcessNumber_l; $ProcessNumber1_l)
	ut_SQLConnect("Designer"; "caesar"; $IPAddress_txt)
	
	C_BLOB:C604(Send_BLB)
	
	C_TEXT:C284($queryType_txt; SQLQuery_txt)
	//VARIABLE TO BLOB($queryType_txt;Send_BLB;*)
	//VARIABLE TO BLOB($IDs_al;Send_BLB;*)
	C_LONGINT:C283(Count_L)
	v_36_010_txt:=String:C10(Size of array:C274($IDs_al))
	For ($Loop_l; 1; Size of array:C274($IDs_al))
		v_36_010_txt:=v_36_010_txt+","+String:C10($IDs_al{$Loop_l})
	End for 
	
	SQLQuery_txt:="SELECT {fn ut_ReturnRecordCountViaSQL(<<v_36_010_txt>>) AS TEXT} FROM Preferences LIMIT 1 INTO :v_36_002_txt;"
	ON ERR CALL:C155("SQL_ERROR")  //
	Begin SQL
		EXECUTE IMMEDIATE :SQLQuery_txt;
	End SQL
	ARRAY TEXT:C222($Parts_atxt; 0)
	ut_NewTextToArray(v_36_002_txt; ->$Parts_atxt; ",")
	
	$Inspcount_L:=Num:C11($Parts_atxt{1})
	$ElementSafetyCount_L:=Num:C11($Parts_atxt{2})
	
	SQL LOGOUT:C872
	
	ALERT:C41("You should end up with "+String:C10($ElementSafetyCount_L)+" Element Safety Records and "+String:C10($Inspcount_L)+" standard photo records")
	
	C_BLOB:C604($Blob_blb)
	SET BLOB SIZE:C606($Blob_blb; 0)
	VARIABLE TO BLOB:C532($IDs_al; $Blob_blb; *)
	
	C_LONGINT:C283($ProcessNumber_l; $ProcessNumber1_l)
	$ProcessNumber1_l:=New process:C317("SQL_NewCloneElementSafety"; 0; "Clone Element Safety "; $Blob_blb; $IPAddress_txt; $ElementSafetyCount_L)
	
	SET BLOB SIZE:C606($Blob_blb; 0)
	VARIABLE TO BLOB:C532($IDs_al; $Blob_blb; *)
	
	$ProcessNumber_l:=New process:C317("SQL_CloneInspectionRelated"; 0; "Clone standard photos "; $Blob_blb; $IPAddress_txt; $Inspcount_L)
	SQLConnectionMade_b:=False:C215
	
	If (False:C215)
		USE SET:C118("BMSSet")
		$RecordCount_l:=Records in selection:C76([BMS Inspections:44])
		ARRAY LONGINT:C221($IDs_al; 0)
		ARRAY LONGINT:C221($IDs_al; $RecordCount_l)
		SELECTION RANGE TO ARRAY:C368(1; $RecordCount_l; [BMS Inspections:44]Inspection ID:1; $IDs_al)
		
		SQLError_b:=False:C215
		4DError_b:=False:C215
		SQLConnectionMade_b:=False:C215
		ut_SQLConnect("Designer"; "caesar"; $IPAddress_txt)
		
		If (SQLConnectionMade_b)
			
			//====begin [InventoryPhotos]
			CREATE EMPTY SET:C140([Bridge MHD NBIS:1]; "FinalSet")
			UNION:C120("INSPBinSet"; "InvPhotSet"; "FinalSet")
			USE SET:C118("FinalSet")
			CLEAR SET:C117("INSPBinSet")
			CLEAR SET:C117("InvPhotSet")
			CLEAR SET:C117("FinalSet")
			
			$RecordCount_l:=Records in selection:C76([Bridge MHD NBIS:1])
			ARRAY TEXT:C222($Bins_as; $RecordCount_l)  // old _ O _ARRAY STRING length 3
			
			SELECTION RANGE TO ARRAY:C368(1; $RecordCount_l; [Bridge MHD NBIS:1]BIN:3; $Bins_as)
			
			QUERY WITH ARRAY:C644([InventoryPhotoInsp:112]BIN:2; $Bins_as)
			$RecordCount_l:=Records in selection:C76([InventoryPhotoInsp:112])
			ARRAY LONGINT:C221($IDs_al; $RecordCount_l)
			SELECTION RANGE TO ARRAY:C368(1; $RecordCount_l; [InventoryPhotoInsp:112]InvPhotoInspID_L:1; $IDs_al)
			
			
			$TableNumber_l:=Table:C252(->[InventoryPhotos:113])
			$TableName_txt:="["+Table name:C256($TableNumber_l)+"]"
			C_TEXT:C284(InspectionBin_txt)
			
			C_POINTER:C301($Table_ptr)
			$Table_ptr:=Table:C252($TableNumber_l)
			
			
			ON ERR CALL:C155("4D_Errors")
			C_TEXT:C284($SelectFields_txt; $UpdateFields_txt; SQL_txt; SQLCount_txt)
			
			clone_CloneSetUpSelectInto($TableNumber_l; ->$SelectFields_txt; ->$UpdateFields_txt; True:C214)
			
			C_LONGINT:C283(Offset_l; Count_l)
			Offset_l:=1
			
			$SelectFields_txt:="IP."+$SelectFields_txt
			$SelectFields_txt:=Replace string:C233($SelectFields_txt; ","; ", IP.")
			SQLCount_txt:="SELECT Count(*) FROM "+$TableName_txt+" IP where IP.InvPhotoInsp_ID = :InspectionIDF_l into :Count_l"
			SQL_txt:="SELECT "+$SelectFields_txt+" FROM "+$TableName_txt+" IP where IP.InvPhotoInsp_ID = :InspectionIDF_l LIMIT "+String:C10(SQL_Limit_L)+" OFFSET :Offset_l INTO "+$UpdateFields_txt
			
			If (Application type:C494#4D Server:K5:6)
				$win:=ut_OpenNewWindow(500; 200; 5; 4; "Retrieving data for table "+$TableName_txt)
				C_TIME:C306($StartTime_tm; $RemainingTime_tm)
				$StartTime_tm:=Current time:C178
			End if 
			C_LONGINT:C283($ArraySize_l; $Loop_l)
			$ArraySize_l:=Size of array:C274($IDs_al)
			
			C_POINTER:C301($Table_ptr)
			
			
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
							If (Size of array:C274(v_113_003_atxt)#SQL_Limit_L)
								Offset_l:=Count_l
							Else 
								Offset_l:=Offset_l+SQL_Limit_L
							End if 
							
							//SET QUERY DESTINATION(Into variable;$RecordCount_l)
							//QUERY([InventoryPhotos];[InventoryPhotos]InvPhoto_ID=v_113_001_l)
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
				
			End for 
			CLOSE WINDOW:C154($win)
			
			//====end [InventoryPhotos]
			
			
		End if 
		ut_SQLLogout
	End if 
	C_TEXT:C284($ProcessName_txt)
	C_LONGINT:C283($Loop_l; $State_l; $ProcessTime_l; $ProcesssUniqueID_i; $ProcessOrigin_l)
	C_BOOLEAN:C305($ProcessVisible_b; $ProcessFound_b)
	
	
	$ProcessFound_b:=False:C215
	For ($Loop_l; 1; Count tasks:C335)
		PROCESS PROPERTIES:C336($Loop_l; $ProcessName_txt; $State_l; $ProcessTime_l; $ProcessVisible_b; $ProcesssUniqueID_i; $ProcessOrigin_l)
		If ($ProcessName_txt="Clone Element Safety@")
			$ProcessFound_b:=True:C214
			$ProcessNumber_l:=$Loop_l
			$Loop_l:=Count tasks:C335+1
		End if 
	End for 
	
	If ($ProcessFound_b)
		Repeat 
			PROCESS PROPERTIES:C336($ProcessNumber_l; $ProcessName_txt; $State_l; $ProcessTime_l; $ProcessVisible_b; $ProcesssUniqueID_i; $ProcessOrigin_l)
			DELAY PROCESS:C323(Current process:C322; 120)
			IDLE:C311
		Until ($State_l<0)
		
	End if 
	
	
	
	$ProcessFound_b:=False:C215
	For ($Loop_l; 1; Count tasks:C335)
		PROCESS PROPERTIES:C336($Loop_l; $ProcessName_txt; $State_l; $ProcessTime_l; $ProcessVisible_b; $ProcesssUniqueID_i; $ProcessOrigin_l)
		If ($ProcessName_txt="Clone standard photos@")
			$ProcessFound_b:=True:C214
			$ProcessNumber_l:=$Loop_l
			$Loop_l:=Count tasks:C335+1
		End if 
	End for 
	
	If ($ProcessFound_b)
		Repeat 
			PROCESS PROPERTIES:C336($ProcessNumber_l; $ProcessName_txt; $State_l; $ProcessTime_l; $ProcessVisible_b; $ProcesssUniqueID_i; $ProcessOrigin_l)
			DELAY PROCESS:C323(Current process:C322; 120)
			IDLE:C311
		Until ($State_l<0)
		
	End if 
	
	C_TIME:C306($EndTime_tm)
	
	$EndTime_tm:=Current time:C178
	
	ALERT:C41("Elapsed time for district "+$District_txt+" is "+String:C10($EndTime_tm-$Beg_tm))
End if 
//End SQL_ControlClone