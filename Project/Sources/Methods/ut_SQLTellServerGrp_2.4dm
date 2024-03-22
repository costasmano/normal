//%attributes = {"invisible":true}
// Method: ut_SQLTellServerGrp_2
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	// ----------------------------------------------------
	// User name (OS): Charles Miller
	// Date and time: 05/06/10, 16:47:58
	// ----------------------------------------------------
	
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:12:49) 
	//Ugrade to v11
	//Modified by: Charles Miller (4/28/11 17:01:28)
	//Ugrade to v11
	//Modified by: Charles Miller (5/3/11 12:14:47)
	//Modify how (Not(4DError_b)) and (Not(SQLError_b)) handled replace with (ut_fTestForSQLor4DError)
	//Modified by: Charles Miller (11/4/11 11:16:31)
	Mods_2012_02  //r002  `Fix bug where sql update with a 0 size picture fails
	//Modified by: Charles Miller (2/9/12 14:41:03)
	// Modified by: Costas Manousakis-(Designer)-(7/20/20 11:04:20)
	Mods_2020_07_bug
	//  `check if datatype in blob is same as the current data type of the field - use the current data type, 
	//  `if different, to define the variable used for the sql transfer. this works only for numeric types.
	//  `Call Reference #729
End if 

C_LONGINT:C283($Numrec_l; $TableNumber_l; $BlobOffset_l; $NumberofFields_l; $Loop_l; $Position_l)
C_BOOLEAN:C305($DataError_b)

SQLError_b:=False:C215
4DError_b:=False:C215
C_TEXT:C284($SQLWhereQuery_txt; $TableName_txt; $SQLSelectQuery_txt; $InsertFieldName_txt; $InsertFieldBind_txt)
$TableNumber_l:=[Activity Log:59]FileID Local:24

$SQLSelectQuery_txt:=ut_SQLReturnSelect(->$SQLWhereQuery_txt; ->$TableName_txt)

$Numrec_l:=ut_SQLSelectForLoad($SQLSelectQuery_txt; [Activity Log:59]Local Type:18)

C_BOOLEAN:C305($OriginalonScreen_b)
$OriginalonScreen_b:=vbOnScreenMessage

C_TEXT:C284($Upd_FieldName_txt; $UpdTableName_txt)
If ($Numrec_l=1) & (ut_fTestForSQLor4DError) & (RecordLocked_b)  //Make sure we just found one record!
	$BlobOffset_l:=0
	C_BLOB:C604($DataBlob_blb; $Local_blb)
	SET BLOB SIZE:C606($DataBlob_blb; 0)
	C_TEXT:C284($Local_txt; $SQL_Fields_txt)
	C_DATE:C307($Local_d)
	C_LONGINT:C283($Local_l; $IsBlobCompressed_l)
	C_TIME:C306($Local_tm)
	C_PICTURE:C286($Local_p)
	C_REAL:C285($Local_r)
	C_BOOLEAN:C305($Local_b)
	$DataBlob_blb:=[Activity Log:59]Data:10
	BLOB PROPERTIES:C536($DataBlob_blb; $IsBlobCompressed_l)
	If ($IsBlobCompressed_l#Is not compressed:K22:11)
		EXPAND BLOB:C535($DataBlob_blb)
	End if 
	$DataError_b:=False:C215
	C_LONGINT:C283($FieldNumber_l; $DataType_l)
	
	BLOB TO VARIABLE:C533($DataBlob_blb; $NumberofFields_l; $BlobOffset_l)
	ARRAY INTEGER:C220($FieldNumbers_al; 0)
	BLOB TO VARIABLE:C533($DataBlob_blb; $FieldNumbers_al; $BlobOffset_l)  //get the list of field numbers
	C_POINTER:C301($Variable_ptr)
	ARRAY TEXT:C222($VariableTypes_atxt; 0)
	ARRAY TEXT:C222($VariableTypes_al; 0)
	C_TEXT:C284($FieldName_s)  // Command Replaced was o_C_STRING length was 80
	
	For ($Loop_l; 1; $NumberofFields_l)
		
		BLOB TO VARIABLE:C533($DataBlob_blb; $FieldNumber_l; $BlobOffset_l)
		BLOB TO VARIABLE:C533($DataBlob_blb; $FieldName_s; $BlobOffset_l)
		BLOB TO VARIABLE:C533($DataBlob_blb; $DataType_l; $BlobOffset_l)
		
		If (Size of array:C274($FieldNumbers_al)=$NumberofFields_l)
			If (Is field number valid:C1000($TableNumber_l; $FieldNumber_l))
				C_LONGINT:C283($currentDataType_L; $sqlVarDatatype_L)
				GET FIELD PROPERTIES:C258([Activity Log:59]FileID Local:24; $FieldNumber_l; $currentDataType_L)
				$sqlVarDatatype_L:=$DataType_l
				//check if the current structure definition matches the one in the blob
				If ($currentDataType_L#$DataType_l)
					//SQL variables are declared in compiler definitions using the current structure definition
					$sqlVarDatatype_L:=$currentDataType_L
				End if 
				
				ut_SQLReturnFromVariablesForSQL([Activity Log:59]FileID Local:24; $FieldNumber_l; $sqlVarDatatype_L; ->$InsertFieldName_txt; ->$InsertFieldBind_txt)
				
				$Variable_ptr:=Get pointer:C304($InsertFieldBind_txt)
				
				Case of 
					: ($DataType_l=Is alpha field:K8:1) | ($DataType_l=Is text:K8:3) | ($DataType_l=Is string var:K8:2)
						BLOB TO VARIABLE:C533($DataBlob_blb; $Local_txt; $BlobOffset_l)
						$Variable_ptr->:=$Local_txt
						
					: ($DataType_l=Is real:K8:4)
						BLOB TO VARIABLE:C533($DataBlob_blb; $Local_r; $BlobOffset_l)
						$Variable_ptr->:=$Local_r
						
					: ($DataType_l=Is integer:K8:5) | ($DataType_l=Is longint:K8:6)
						BLOB TO VARIABLE:C533($DataBlob_blb; $Local_l; $BlobOffset_l)
						$Variable_ptr->:=$Local_l
						
					: ($DataType_l=Is date:K8:7)
						BLOB TO VARIABLE:C533($DataBlob_blb; $Local_d; $BlobOffset_l)
						$Variable_ptr->:=$Local_d
						
					: ($DataType_l=Is time:K8:8)
						BLOB TO VARIABLE:C533($DataBlob_blb; $Local_tm; $BlobOffset_l)
						$Variable_ptr->:=$Local_tm
						
					: ($DataType_l=Is boolean:K8:9)
						BLOB TO VARIABLE:C533($DataBlob_blb; $Local_b; $BlobOffset_l)
						$Variable_ptr->:=$Local_b
						
					: ($DataType_l=Is picture:K8:10)
						BLOB TO VARIABLE:C533($DataBlob_blb; $Local_p; $BlobOffset_l)
						$Variable_ptr->:=$Local_p
						If (Picture size:C356($Variable_ptr->)=0)
							GET PICTURE FROM LIBRARY:C565(30288; $Variable_ptr->)
						End if 
						
					: ($DataType_l=Is BLOB:K8:12)
						BLOB TO VARIABLE:C533($DataBlob_blb; $Local_blb; $BlobOffset_l)
						$Variable_ptr->:=$Local_blb
						
					Else 
						ut_SQLWriteErrorsToLog("Act Log errorType "+Current method name:C684+" Type returned was "+String:C10($DataType_l)+" for -ID "+String:C10([Activity Log:59]RefID:28)+<>sCR)
						
						$DataError_b:=True:C214
				End case 
				
				$Position_l:=Find in array:C230($FieldNumbers_al; $FieldNumbers_al{$Loop_l})
				If ($Position_l=$Loop_l)  //add to update fild names
					If ($SQL_Fields_txt="")
						$SQL_Fields_txt:=$InsertFieldName_txt+" = :"+$InsertFieldBind_txt
					Else 
						$SQL_Fields_txt:=$SQL_Fields_txt+" , "+$InsertFieldName_txt+" = :"+$InsertFieldBind_txt
					End if 
				End if 
				
			End if 
		Else 
			ut_SQLWriteErrorsToLog("Act Log errorType "+Current method name:C684+" # fields did not match what was in array for -ID "+String:C10([Activity Log:59]RefID:28)+<>sCR)
			
			$DataError_b:=True:C214
		End if 
	End for 
	
	
	If (Not:C34($DataError_b))
		C_TEXT:C284($SQLUpdate_txt)
		$SQLUpdate_txt:="UPDATE "+$TableName_txt+Char:C90(Carriage return:K15:38)+"SET "+Char:C90(Carriage return:K15:38)
		$SQLUpdate_txt:=$SQLUpdate_txt+$SQL_Fields_txt+""+Char:C90(Carriage return:K15:38)
		$SQLUpdate_txt:=$SQLUpdate_txt+$SQLWhereQuery_txt+""+Char:C90(Carriage return:K15:38)
		ut_SQLExecuteNoReturn($SQLUpdate_txt)
		
		If (ut_fTestForSQLor4DError)
			
			ut_SQLUpdateServerActLog
			
		Else 
			ut_SQLWriteErrorsToLog("Act Log error in update "+Current method name:C684+" -ID "+String:C10([Activity Log:59]RefID:28)+<>sCR)
			vbOnScreenMessage:=False:C215
			ut_Message($SQLUpdate_txt)
		End if 
	End if 
Else 
	If (Not:C34(RecordLocked_b))
	Else 
		ut_SQLWriteCommonError(Current method name:C684; $Numrec_l; $SQLSelectQuery_txt)
	End if 
End if 
vbOnScreenMessage:=$OriginalonScreen_b