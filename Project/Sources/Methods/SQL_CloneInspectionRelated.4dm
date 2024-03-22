//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 12/02/10, 14:07:58
//----------------------------------------------------
//Method: SQL_CloneInspectionRelated
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//Ugrade to v11
	//Modified by: Charles Miller (12/2/10 14:08:00)
	//Modify how (Not(4DError_b)) and (Not(SQLError_b)) handled replace with (ut_fTestForSQLor4DError)
	//Modified by: Charles Miller (11/4/11 11:18:39)
	Mods_2018_06
	//Mods_2019_08  //Fixed error in following two clone methods and changed to use new progress bar component
	//Error was that the The did not use blob arrays and some clone directives where not defined
	//Modified by: Chuck Miller (8/22/19 13:13:49)
	Mods_2020_01  //Moved changed clone code for new data file in to make sure arrays are used from BF
	//Modified by: CJ (1/14/20 11:46:37)
	Mods_2020_01  //Modified to fix logic issues and to use new funciton to return number of expected records from BF
	//Modified by: CJ (1/21/20 11:11:11)
End if 
READ WRITE:C146(*)
TRUNCATE TABLE:C1051([Standard Photos:36])

Compiler_FieldVariables
Compiler_clone
clone_IncludeUUIDS_B:=False:C215
clone_UseBlobArrays_B:=True:C214
ut_InitFieldArray
C_BLOB:C604($1; $Blob_blb)
$Blob_blb:=$1
C_TEXT:C284($IPAddress_txt; $2)
$IPAddress_txt:=$2
READ WRITE:C146(*)
C_LONGINT:C283($ImportCount_L; $3; $RecordCount_L)
$ImportCount_L:=$3
SQLError_b:=False:C215
4DError_b:=False:C215
SQLConnectionMade_b:=False:C215
arbNew_l:=1
arbOld_l:=0
clone_UseBlobArrays_L:=1
clone_UseBlobArrays_B:=True:C214

clone_CreateSQLLimits
ARRAY TEXT:C222(clone_TablesWithUniqueKey_atxt; 0)
ARRAY POINTER:C280(clone_UniqueKeys_aptr; 0)
ARRAY POINTER:C280(clone_Array_aptr; 0)
ARRAY POINTER:C280(clone_Table_aPtr; 0)
ARRAY BOOLEAN:C223($HasPictureOrBlob_ab; 0)
C_TEXT:C284($Variable_txt; $SQL_Where_txt; $In_txt)
C_LONGINT:C283($TableNumber_l; ->$UniqueFldNumber_l; $INCount_L)
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

ut_SQLConnect("Designer"; "caesar"; $IPAddress_txt)

C_BOOLEAN:C305($UpdateDisplay_b)

If (SQLConnectionMade_b)
	clone_CreateremoteMissingFields
	ARRAY LONGINT:C221($IDs_al; 0)
	C_LONGINT:C283($Offset_l; $TableNumber_l; $Win; $RecordCount_l)
	$Offset_l:=0
	BLOB TO VARIABLE:C533($Blob_blb; $IDs_al; $Offset_l)
	
	
	//[Standard Photos]
	$TableNumber_l:=Table:C252(->[Standard Photos:36])
	
	C_POINTER:C301($Table_ptr)
	$Table_ptr:=Table:C252($TableNumber_l)
	
	C_TEXT:C284($TableName_txt)
	$TableName_txt:="["+Table name:C256($TableNumber_l)+"]"
	
	ON ERR CALL:C155("4D_Errors")
	C_TEXT:C284($SelectFields_txt; $UpdateFields_txt; SQL_txt)
	C_LONGINT:C283(Count_l)
	clone_CloneSetUpSelectInto($TableNumber_l; ->$SelectFields_txt; ->$UpdateFields_txt; True:C214)
	//SQL_SetSelectInto ($TableNumber_l;->$SelectFields_txt;->$UpdateFields_txt)
	//SQLCount_txt:="SELECT Count(*) FROM "+$TableName_txt+" where [Standard Photos].InspID=:InspectionIDF_l INTO :Count_l"
	//
	//SQL_txt:="SELECT "+$SelectFields_txt+" FROM "+$TableName_txt+" where [Standard Photos].InspID=:InspectionIDF_l LIMIT "+String(sql_limit_L)+" OFFSET :Offset_l INTO "+$UpdateFields_txt
	C_OBJECT:C1216($progressobj_o)
	//If (Application type#4D Server)
	//$win:=ut_OpenNewWindow (500;200;5;4;"Retrieving data for table "+$TableName_txt)
	//C_TIME($StartTime_tm;$RemainingTime_tm)
	//$StartTime_tm:=Current time
	//End if 
	C_LONGINT:C283($ArraySize_l; $Loop_l; InspectionIDF_l)
	$Loop_l:=1
	$ArraySize_l:=Size of array:C274($IDs_al)
	$progressobj_o:=ProgressNew("Cloning Inspection Related Data for "+$TableName_txt; $ImportCount_L; True:C214; ""; 3)
	
	Repeat 
		
		SQLCount_txt:="SELECT Count(*) FROM "+$TableName_txt  //" where [Standard Photos].InspID  INTO :Count_l"
		
		SQL_txt:="SELECT "+$SelectFields_txt+" FROM "+$TableName_txt+" "  //+" where [Standard Photos].InspID=:InspectionIDF_l LIMIT "+String(sql_limit_L)+" OFFSET :Offset_l INTO "+$UpdateFields_txt
		$SQL_Where_txt:=" where [Standard Photos].InspID in (?) "
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
		SQL_txt:=SQL_txt+$SQL_Where_txt+" LIMIT "+String:C10(sql_limit_L)+"OFFSET :Offset_l INTO "+$UpdateFields_txt
		SQLCount_txt:=SQLCount_txt+$SQL_Where_txt+" into :Count_l "
		//InspectionIDF_l:=$IDs_al{$Loop_l}
		//If (Application type#4D Server)
		
		//GOTO XY(5;2)
		//MESSAGE("Updating "+String($Loop_l)+" out of "+String($ArraySize_l))
		//GOTO XY(5;5)
		//$RemainingTime_tm:=(($ArraySize_l/$Loop_l)-1)*(Current time(*)-$StartTime_tm)
		//MESSAGE("Estimated time remaining is "+Time string($RemainingTime_tm))
		//GOTO XY(5;7)
		//MESSAGE("Elapsed time is "+Time string(Current time(*)-$StartTime_tm))
		
		//End if 
		
		ON ERR CALL:C155("SQL_Error")
		Begin SQL
			EXECUTE IMMEDIATE :SQLCount_txt;
		End SQL
		
		ON ERR CALL:C155("4D_Errors")
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
					REDUCE SELECTION:C351([Standard Photos:36]; 0)
					Clone_ArrayToSelection($TableNumber_l)
					//If (Size of array(v_36_002_atxt)#SQL_Limit_L)
					//Offset_l:=Count_l
					//Else 
					//Offset_l:=Offset_l+SQL_Limit_L
					//End if 
				End if 
				If (Records in table:C83([Standard Photos:36])=0)
					$RecordCount_L:=1
				Else 
					$RecordCount_L:=Records in table:C83([Standard Photos:36])
				End if 
				UpdateProgressNew($progressObj_o; $RecordCount_L)
			Until (Offset_l=Count_l) | (4DError_b) | (SQLError_b)
		End if 
		
	Until ($Loop_l>$ArraySize_l)
	CLOSE WINDOW:C154
	UNLOAD RECORD:C212($Table_ptr->)
	
	ut_SQLLogout
	
	Progress QUIT(OB Get:C1224($progressObj_o; "progress"))
End if 
//End SQL_CloneInspectionRelated
