//%attributes = {"invisible":true}
//Method: ut_SQLTellServerNRI
//Description
// upload to remote server an NRI (new record init) activity log record
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/18/21, 16:51:12
	// ----------------------------------------------------
	//Created : 
	Mods_2021_02
	
	Mods_StillWorkingOn
	
	// Modified by: Costas Manousakis-(Designer)-(2022-09-15 19:14:45)
	Mods_2022_09_bug
	//replaced picref 30288 with the name "EmptyPicture"
End if 
//

//STILLWORKINGONTHIS:=True

C_LONGINT:C283($Numrec_l; $TableNumber_l; $BlobOffset_l; $NumberofFields_l; $Loop_l; $Position_l)
C_BOOLEAN:C305($DataError_b)

SQLError_b:=False:C215
4DError_b:=False:C215

C_TEXT:C284($SQLWhereQuery_txt; $TableName_txt; $SQLSelectQuery_txt; $InsertFieldName_txt; $InsertFieldBind_txt)
$TableNumber_l:=[Activity Log:59]FileID Local:24

C_TEXT:C284($TableName_txt; $FieldName_txt; $ParentField_txt; $SQLInsertInto_txt; $FieldNames_txt; $Values_txt)
SQL_utReturnStrings([Activity Log:59]FileID Local:24; [Activity Log:59]FieldID Local:25; ->$FieldName_txt; ->$TableName_txt)
SQL_utReturnStrings([Activity Log:59]FileID Local:24; [Activity Log:59]FieldID Parent:23; ->$ParentField_txt)
If ([Activity Log:59]RefIDType:26=0)
	$FieldNames_txt:=$FieldName_txt
	$Values_txt:=""
	If ([Activity Log:59]Local Type:18=0)
		ParentID_s:=[Activity Log:59]Local ID:15
		$Values_txt:=":ParentID_s"
	Else 
		ParentID_l:=Num:C11([Activity Log:59]Local ID:15)
		$Values_txt:=":ParentID_l"
	End if 
	
Else 
	If ([Activity Log:59]RefIDType:26#3)
		//C_TEXT($SeqName_txt)
		//BLOB TO VARIABLE([Activity Log]Data;$SeqName_txt)
		RefID_l:=RemoteUniquekey_l  //SQL_RetrieveNextID ($SeqName_txt)
		RefID_s:=String:C10(RefID_l)
	End if 
	Case of 
		: ([Activity Log:59]RefIDType:26=1)
			$FieldNames_txt:=$ParentField_txt
			$Values_txt:=""
			If ([Activity Log:59]Type Parent:17=0)
				ParentID_s:=[Activity Log:59]Parent ID:14
				$Values_txt:=":ParentID_s"
			Else 
				ParentID_l:=Num:C11([Activity Log:59]Parent ID:14)
				$Values_txt:=":ParentID_l"
			End if 
			If ([Activity Log:59]Local Type:18=0)
				$Values_txt:=$Values_txt+", :RefID_s"
			Else 
				$Values_txt:=$Values_txt+", :RefID_l"
			End if 
			$FieldNames_txt:=$FieldNames_txt+", "+$FieldName_txt
			
		: ([Activity Log:59]RefIDType:26=2)
			$FieldNames_txt:=$ParentField_txt
			If ([Activity Log:59]Dest ID parent:16="")
				ParentID_s:=aLookUpDest([Activity Log:59]FileID Parent:22; [Activity Log:59]Parent ID:14; <>Destination)
				//Danger!
				If (ParentID_s="")  //Assume local id and remote are the same!
					ParentID_s:=[Activity Log:59]Parent ID:14
				End if 
				[Activity Log:59]Dest ID parent:16:=ParentID_s
			Else 
				ParentID_s:=[Activity Log:59]Dest ID parent:16
			End if 
			If ([Activity Log:59]Type Parent:17=0)
				$Values_txt:=":ParentID_s"
			Else 
				ParentID_l:=Num:C11(ParentID_s)
				$Values_txt:=":ParentID_l"
			End if 
			If ([Activity Log:59]Local Type:18=0)
				$Values_txt:=$Values_txt+", :RefID_s"
			Else 
				$Values_txt:=$Values_txt+", :RefID_l"
			End if 
			$FieldNames_txt:=$FieldNames_txt+", "+$FieldName_txt
			
		: ([Activity Log:59]RefIDType:26=3)
			$FieldNames_txt:=$ParentField_txt
			If ([Activity Log:59]Dest ID parent:16="")
				ParentID_s:=aLookUpDest([Activity Log:59]FileID Parent:22; [Activity Log:59]Parent ID:14; <>Destination)
				//Danger!
				If (ParentID_s="")  //Assume local id and remote are the same!
					ParentID_s:=[Activity Log:59]Parent ID:14
				End if 
				[Activity Log:59]Dest ID parent:16:=ParentID_s
			Else 
				ParentID_s:=[Activity Log:59]Dest ID parent:16
			End if 
			If ([Activity Log:59]Type Parent:17=0)
				$Values_txt:=":ParentID_s"
			Else 
				ParentID_l:=Num:C11(ParentID_s)
				$Values_txt:=":ParentID_l"
			End if 
			If ([Activity Log:59]Dest ID local:19="")
				RefID_s:=aLookUpDest([Activity Log:59]File Number:7; [Activity Log:59]Local ID:15; <>Destination)
				//Danger!
				If (RefID_s="")  //Assume local id and remote are the same!
					RefID_s:=[Activity Log:59]Local ID:15
				End if 
				[Activity Log:59]Dest ID local:19:=RefID_s
			Else 
				RefID_s:=[Activity Log:59]Dest ID local:19
			End if 
			If ([Activity Log:59]Local Type:18=0)
				$Values_txt:=$Values_txt+", :RefID_s"
			Else 
				RefID_l:=Num:C11(RefID_s)
				$Values_txt:=$Values_txt+", :RefID_l"
			End if 
			$FieldNames_txt:=$FieldNames_txt+", "+$FieldName_txt
			
		: ([Activity Log:59]RefIDType:26=4)
			RefID_s:=String:C10(RefID_l)
			$FieldNames_txt:=$FieldName_txt
			$Values_txt:=""
			If ([Activity Log:59]Local Type:18=0)
				$Values_txt:=":RefID_s"
			Else 
				$Values_txt:=":RefID_l"
			End if 
			
	End case 
End if 

C_BOOLEAN:C305($OriginalonScreen_b)
$OriginalonScreen_b:=vbOnScreenMessage

C_TEXT:C284($Upd_FieldName_txt; $UpdTableName_txt)

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

C_TEXT:C284($sequence)
BLOB TO VARIABLE:C533($DataBlob_blb; $sequence; $BlobOffset_l)  // need to get the sequnce name out of the blob first

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
						GET PICTURE FROM LIBRARY:C565("EmptyPicture"; $Variable_ptr->)
					End if 
					
				: ($DataType_l=Is BLOB:K8:12)
					BLOB TO VARIABLE:C533($DataBlob_blb; $Local_blb; $BlobOffset_l)
					$Variable_ptr->:=$Local_blb
					
				Else 
					ut_SQLWriteErrorsToLog("Act Log error "+Current method name:C684+" Type returned was "+String:C10($DataType_l)+" for -ID "+String:C10([Activity Log:59]RefID:28)+<>sCR)
					
					$DataError_b:=True:C214
			End case 
			
			$Position_l:=Find in array:C230($FieldNumbers_al; $FieldNumbers_al{$Loop_l})
			If ($Position_l=$Loop_l)  //add to update field names
				$FieldNames_txt:=$FieldNames_txt+" , "+$InsertFieldName_txt
				$Values_txt:=$Values_txt+" , :"+$InsertFieldBind_txt
			End if 
			
		End if 
	Else 
		ut_SQLWriteErrorsToLog("Act Log error "+Current method name:C684+" # fields did not match what was in array for -ID "+String:C10([Activity Log:59]RefID:28)+<>sCR)
		
		$DataError_b:=True:C214
	End if 
End for 


If (Not:C34($DataError_b))
	$SQLInsertInto_txt:=$SQLInsertInto_txt+"INSERT INTO "+$TableName_txt+" ("+$FieldNames_txt+")"+Char:C90(Carriage return:K15:38)
	$SQLInsertInto_txt:=$SQLInsertInto_txt+"VALUES ("+$Values_txt+");"+Char:C90(Carriage return:K15:38)
	
	ut_SQLExecuteNoReturn($SQLInsertInto_txt)
	
	C_BOOLEAN:C305($OriginalonScreen_b; $UpdateServerActLog_b)
	$UpdateServerActLog_b:=True:C214
	$OriginalonScreen_b:=vbOnScreenMessage
	If (SQLError_b)
		C_TEXT:C284($MyTableName_txt)
		$MyTableName_txt:=Replace string:C233($TableName_txt; "["; "")
		$MyTableName_txt:=Replace string:C233($MyTableName_txt; "]"; "")
		
		If (Find in array:C230(IgnoreDuplicateKeyTables_atxt; $MyTableName_txt)>0)
			If (Find in array:C230(SQLErrorNumbers_al; 1115)>0)
				//if table is in the IgnoreDups list, then no Error but also do not propagate the NRC activity to other dbs
				SQLError_b:=False:C215
				$UpdateServerActLog_b:=False:C215
				//mark record as sent here - normally done in ut_SQLUpdateServerActLog , but it will not be called
				[Activity Log:59]Status:9:=1
				SAVE RECORD:C53([Activity Log:59])
				
				ut_Message("Ignored Duplicated Key in table "+$TableName_txt+" keyfield "+$FieldNames_txt+" = "+$Values_txt+Char:C90(Carriage return:K15:38))
			End if 
		End if 
		
	End if 
	If (ut_fTestForSQLor4DError)
		If (([Activity Log:59]RefIDType:26=1) | ([Activity Log:59]RefIDType:26=2) | ([Activity Log:59]RefIDType:26=4))
			[Activity Log:59]Dest ID local:19:=RefID_s
			//Add entries into the file address resolution table
			G_StoreRecResolution([Activity Log:59]FileID Local:24; [Activity Log:59]Local ID:15; RefID_s; <>Destination)
		End if 
		
		If ($UpdateServerActLog_b)
			ut_SQLUpdateServerActLog
		End if 
		
	Else 
		
		ut_SQLWriteErrorsToLog("Act Log error in "+Current method name:C684+"  -ID"+String:C10([Activity Log:59]RefID:28)+<>sCR)
		vbOnScreenMessage:=False:C215
		ut_Message($SQLInsertInto_txt)
	End if 
	
	vbOnScreenMessage:=$OriginalonScreen_b
	
Else 
	
End if 


//End ut_SQLTellServerNRI