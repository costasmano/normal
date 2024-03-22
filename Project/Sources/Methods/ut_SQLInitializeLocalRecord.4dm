//%attributes = {"invisible":true}
//Method: ut_SQLInitializeLocalRecord
//Description
// initialize a new local record from activity log type NRI
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/18/21, 19:06:11
	// ----------------------------------------------------
	//Created : 
	Mods_2021_02
	Mods_StillWorkingOn
End if 
//
//STILLWORKINGONTHIS:=True

C_TEXT:C284($LocalID_s; $ParentID_s; $RefID_s)  // Command Replaced was o_C_STRING length was 80
C_LONGINT:C283($RefID_l)
C_POINTER:C301($LocalTable_ptr; $LocalFld_ptr; $idparent; $ParentTable_ptr; $ParentField_ptr)
$LocalTable_ptr:=Table:C252([Activity Log:59]FileID Local:24)
$LocalFld_ptr:=Field:C253([Activity Log:59]FileID Local:24; [Activity Log:59]FieldID Local:25)
C_LONGINT:C283($NewRef_l; $UniqueFldNumber_l; $Count_l; $Type_l; $Length_l)
C_BOOLEAN:C305($Indexed_b; $Unique_b; $Invisible_b)
C_TEXT:C284($SequenceName_txt; $Variable_txt)
C_TEXT:C284($Parentid_s; $Localid_s)  // Command Replaced was o_C_STRING length was 80
SaveActivityLogRecord_b:=True:C214
MissingParent_B:=False:C215
C_LONGINT:C283($Compressed_l; $Offset_l)
C_BLOB:C604($Data_blb)
SET BLOB SIZE:C606($Data_blb; 0)

$Data_blb:=[Activity Log:59]Data:10
BLOB PROPERTIES:C536($Data_blb; $Compressed_l)
If ($Compressed_l#Is not compressed:K22:11)
	EXPAND BLOB:C535($Data_blb)
End if 
$Offset_l:=0
BLOB TO VARIABLE:C533($Data_blb; $SequenceName_txt; $Offset_l)

Case of 
	: ([Activity Log:59]RefIDType:26=0)
		$RefID_s:=[Activity Log:59]Local ID:15
		$RefID_l:=Num:C11($RefID_s)
		CREATE RECORD:C68($LocalTable_ptr->)
		If ([Activity Log:59]Local Type:18=0)
			$LocalFld_ptr->:=$RefID_s
		Else 
			$LocalFld_ptr->:=$RefID_l
		End if 
		$Localid_s:=$RefID_s
		$Parentid_s:=[Activity Log:59]Parent ID:14
	: ([Activity Log:59]RefIDType:26=1)
		
		$idparent:=Field:C253([Activity Log:59]FileID Local:24; [Activity Log:59]FieldID Parent:23)
		BLOB TO VARIABLE:C533([Activity Log:59]Data:10; $SequenceName_txt)
		Inc_Sequence($SequenceName_txt; ->$NewRef_l)
		
		CREATE RECORD:C68($LocalTable_ptr->)
		If ([Activity Log:59]Type Parent:17=0)
			$idparent->:=[Activity Log:59]Parent ID:14
		Else 
			$idparent->:=Num:C11([Activity Log:59]Parent ID:14)
		End if 
		If ([Activity Log:59]Local Type:18=0)
			$LocalFld_ptr->:=String:C10($NewRef_l)
		Else 
			$LocalFld_ptr->:=$NewRef_l
		End if 
		//Add entries into the file address resolution table
		G_StoreRecResolution([Activity Log:59]FileID Local:24; String:C10($NewRef_l); [Activity Log:59]Local ID:15; <>Destination)
		$Localid_s:=String:C10($NewRef_l)
		$Parentid_s:=[Activity Log:59]Parent ID:14
	: ([Activity Log:59]RefIDType:26=2)
		
		clone_ReturnKeyFldandVariable([Activity Log:59]FileID Parent:22; ->$UniqueFldNumber_l; ->$Variable_txt; False:C215)
		$ParentTable_ptr:=Table:C252([Activity Log:59]FileID Parent:22)
		$ParentField_ptr:=Field:C253([Activity Log:59]FileID Parent:22; $UniqueFldNumber_l)
		
		$idparent:=Field:C253([Activity Log:59]FileID Local:24; [Activity Log:59]FieldID Parent:23)
		BLOB TO VARIABLE:C533([Activity Log:59]Data:10; $SequenceName_txt)
		Inc_Sequence($SequenceName_txt; ->$NewRef_l)
		
		$Parentid_s:=aDblLookUpDest([Activity Log:59]FileID Parent:22; [Activity Log:59]Parent ID:14; "here"; <>Destination)
		GET FIELD PROPERTIES:C258([Activity Log:59]FileID Parent:22; $UniqueFldNumber_l; $Type_l; $Length_l; $Indexed_b; $Unique_b; $Invisible_b)
		
		SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_l)
		$Count_l:=-1
		Case of 
			: ($Type_l=Is integer:K8:5) | ($Type_l=Is longint:K8:6) | ($Type_l=Is real:K8:4)
				QUERY:C277($ParentTable_ptr->; $ParentField_ptr->=Num:C11($Parentid_s))
				
			: ($Type_l=Is alpha field:K8:1) | ($Type_l=Is text:K8:3)
				QUERY:C277($ParentTable_ptr->; $ParentField_ptr->=$Parentid_s)
			Else 
				
				
		End case 
		
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If ($Count_l=1)
			
			CREATE RECORD:C68($LocalTable_ptr->)
			
			If ([Activity Log:59]Type Parent:17=0)
				$idparent->:=$Parentid_s
			Else 
				$idparent->:=Num:C11($Parentid_s)
			End if 
			If ([Activity Log:59]Local Type:18=0)
				$LocalFld_ptr->:=String:C10($NewRef_l)
			Else 
				$LocalFld_ptr->:=$NewRef_l
			End if 
			
		Else 
			SaveActivityLogRecord_b:=False:C215
		End if 
		//Add entries into the file address resolution table even if we did not create a local record - this for future reference
		G_StoreRecResolution([Activity Log:59]FileID Local:24; String:C10($NewRef_l); [Activity Log:59]Local ID:15; <>Destination)
		$Localid_s:=String:C10($NewRef_l)
		$Parentid_s:=$Parentid_s
		
	: ([Activity Log:59]RefIDType:26=3)
		
		clone_ReturnKeyFldandVariable([Activity Log:59]FileID Parent:22; ->$UniqueFldNumber_l; ->$Variable_txt; False:C215)
		$ParentTable_ptr:=Table:C252([Activity Log:59]FileID Parent:22)
		$ParentField_ptr:=Field:C253([Activity Log:59]FileID Parent:22; $UniqueFldNumber_l)
		
		$Parentid_s:=aDblLookUpDest([Activity Log:59]FileID Parent:22; [Activity Log:59]Parent ID:14; "Here"; <>Destination)
		
		GET FIELD PROPERTIES:C258([Activity Log:59]FileID Parent:22; $UniqueFldNumber_l; $Type_l; $Length_l; $Indexed_b; $Unique_b; $Invisible_b)
		
		SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_l)
		$Count_l:=-1
		Case of 
			: ($Type_l=Is integer:K8:5) | ($Type_l=Is longint:K8:6) | ($Type_l=Is real:K8:4)
				QUERY:C277($ParentTable_ptr->; $ParentField_ptr->=Num:C11($Parentid_s))
				
			: ($Type_l=Is alpha field:K8:1) | ($Type_l=Is text:K8:3)
				QUERY:C277($ParentTable_ptr->; $ParentField_ptr->=$Parentid_s)
			Else 
				
				
		End case 
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		
		If ($Count_l=1)
			$idparent:=Field:C253([Activity Log:59]FileID Local:24; [Activity Log:59]FieldID Parent:23)
			CREATE RECORD:C68($LocalTable_ptr->)
			
			//Danger!
			//If (aparentid="")  `Assume local id and remote are the same!
			// aparentid:=ActParentID
			//End if 
			If ([Activity Log:59]Type Parent:17=0)
				$idparent->:=$Parentid_s
			Else 
				
				$idparent->:=Num:C11($Parentid_s)
			End if 
			$Localid_s:=aDblLookUpDest([Activity Log:59]File Number:7; [Activity Log:59]Local ID:15; "here"; <>Destination)
			//Danger!
			//If (alocalid="")  `Assume local id and remote are the same!
			// alocalid:=[Activity Log]Local ID
			//End if 
			If ([Activity Log:59]Local Type:18=0)
				$LocalFld_ptr->:=$Localid_s
			Else 
				$LocalFld_ptr->:=Num:C11($Localid_s)
			End if 
			
			$Localid_s:=$Localid_s
			$Parentid_s:=$Parentid_s
		Else 
			SaveActivityLogRecord_b:=False:C215
		End if 
	: ([Activity Log:59]RefIDType:26=4)
		BLOB TO VARIABLE:C533([Activity Log:59]Data:10; $SequenceName_txt)
		Inc_Sequence($SequenceName_txt; ->$NewRef_l)
		
		CREATE RECORD:C68($LocalTable_ptr->)
		If ([Activity Log:59]Local Type:18=0)
			$LocalFld_ptr->:=String:C10($NewRef_l)
		Else 
			$LocalFld_ptr->:=$NewRef_l
		End if 
		//Put an entry into the file address resolution table
		G_StoreRecResolution([Activity Log:59]FileID Local:24; String:C10($NewRef_l); [Activity Log:59]Local ID:15; <>Destination)
		$Localid_s:=String:C10($NewRef_l)
		$Parentid_s:=""
End case 

If (Not:C34(4DError_b))
	If (SaveActivityLogRecord_b)
		
		C_LONGINT:C283($NumFlds_l; $Offset_l; $Loop_l; $FieldNumber_l; $Data_blbType_l)
		BLOB TO VARIABLE:C533($Data_blb; $NumFlds_l; $Offset_l)
		ARRAY INTEGER:C220($aiFldsChanged; 0)
		BLOB TO VARIABLE:C533($Data_blb; $aiFldsChanged; $Offset_l)
		C_TEXT:C284($PassFieldName_txt; $CalcFieldName_txt)
		C_POINTER:C301($FieldToUpdate_ptr)
		C_TEXT:C284($Data_txt)
		C_DATE:C307($Data_d)
		C_TIME:C306($Data_tm)
		C_LONGINT:C283($Data_l)
		C_REAL:C285($Data_r)
		C_PICTURE:C286($Data_p)
		C_BOOLEAN:C305($Data_b)
		C_BLOB:C604($Old_blb)
		SET BLOB SIZE:C606($Old_blb; 0)
		
		C_TEXT:C284($ChangedFields_txt)
		
		For ($Loop_l; 1; $NumFlds_l)
			
			BLOB TO VARIABLE:C533($Data_blb; $FieldNumber_l; $Offset_l)
			BLOB TO VARIABLE:C533($Data_blb; $PassFieldName_txt; $Offset_l)
			BLOB TO VARIABLE:C533($Data_blb; $Data_blbType_l; $Offset_l)
			C_LONGINT:C283($DataTypeCheck_l)
			If ($ChangedFields_txt="")
				$ChangedFields_txt:=$PassFieldName_txt
			Else 
				
				$ChangedFields_txt:=$ChangedFields_txt+", "+$PassFieldName_txt
			End if 
			$DataTypeCheck_l:=-1
			$CalcFieldName_txt:=""
			If ($FieldNumber_l<=Get last field number:C255([Activity Log:59]File Number:7))
				GET FIELD PROPERTIES:C258([Activity Log:59]File Number:7; $FieldNumber_l; $DataTypeCheck_l)
				$CalcFieldName_txt:=Field name:C257([Activity Log:59]File Number:7; $FieldNumber_l)
			End if 
			If (($PassFieldName_txt#$CalcFieldName_txt) | ($DataTypeCheck_l#$Data_blbType_l))
				Case of 
						
					: ($Data_blbType_l=Is alpha field:K8:1) | ($Data_blbType_l=Is text:K8:3)  //Alpha
						BLOB TO VARIABLE:C533($Data_blb; $Data_txt; $Offset_l)
						
					: ($Data_blbType_l=Is real:K8:4)  //Real
						BLOB TO VARIABLE:C533($Data_blb; $Data_r; $Offset_l)
						
						
					: ($Data_blbType_l=Is picture:K8:10)  //Picture
						BLOB TO VARIABLE:C533($Data_blb; $Data_p; $Offset_l)
						
					: ($Data_blbType_l=Is date:K8:7)  //Date
						BLOB TO VARIABLE:C533($Data_blb; $Data_d; $Offset_l)
						
					: ($Data_blbType_l=Is boolean:K8:9)  //Boolean
						BLOB TO VARIABLE:C533($Data_blb; $Data_b; $Offset_l)
						
					: ($Data_blbType_l=Is integer:K8:5) | ($Data_blbType_l=Is longint:K8:6)  //Integer
						BLOB TO VARIABLE:C533($Data_blb; $Data_l; $Offset_l)
						
					: ($Data_blbType_l=Is time:K8:8)  //Time
						BLOB TO VARIABLE:C533($Data_blb; $Data_tm; $Offset_l)
						
					: ($Data_blbType_l=Is BLOB:K8:12)  //Blob
						C_BLOB:C604($xBlob)
						
						BLOB TO VARIABLE:C533($Data_blb; $xBlob; $Offset_l)
						SET BLOB SIZE:C606($xBlob; 0)
				End case 
				If ($PassFieldName_txt#$CalcFieldName_txt)
					ut_Message("Field mismatch $CalcFieldName_txt = "+$CalcFieldName_txt+" $PassFieldName_txt "+$PassFieldName_txt+<>sCR)  //No display of data"
				Else 
					ut_Message("Field Type mismatch $CalcFieldName_txt = "+$CalcFieldName_txt+" local type  "+String:C10($DataTypeCheck_l)+" passed type "+String:C10($Data_blbType_l)+<>sCR)  //No display of data"
					
				End if 
			Else 
				$FieldToUpdate_ptr:=Field:C253([Activity Log:59]File Number:7; $FieldNumber_l)  //point to the data
				//for all types except Text Blob and Pict we need to read the var twice
				//once for new data value once for Old data value.
				
				Case of 
						
					: ($Data_blbType_l=Is alpha field:K8:1) | ($Data_blbType_l=Is text:K8:3)  //Alpha
						BLOB TO VARIABLE:C533($Data_blb; $Data_txt; $Offset_l)
						$FieldToUpdate_ptr->:=$Data_txt
						
					: ($Data_blbType_l=Is real:K8:4)  //Real
						BLOB TO VARIABLE:C533($Data_blb; $Data_r; $Offset_l)
						$FieldToUpdate_ptr->:=$Data_r
						
					: ($Data_blbType_l=Is picture:K8:10)  //Picture
						BLOB TO VARIABLE:C533($Data_blb; $Data_p; $Offset_l)
						$FieldToUpdate_ptr->:=$Data_p
						
					: ($Data_blbType_l=Is date:K8:7)  //Date
						BLOB TO VARIABLE:C533($Data_blb; $Data_d; $Offset_l)
						$FieldToUpdate_ptr->:=$Data_d
						
					: ($Data_blbType_l=Is boolean:K8:9)  //Boolean
						BLOB TO VARIABLE:C533($Data_blb; $Data_b; $Offset_l)
						$FieldToUpdate_ptr->:=$Data_b
						
					: ($Data_blbType_l=Is integer:K8:5) | ($Data_blbType_l=Is longint:K8:6)  //Integer
						BLOB TO VARIABLE:C533($Data_blb; $Data_l; $Offset_l)
						$FieldToUpdate_ptr->:=$Data_l
						
					: ($Data_blbType_l=Is time:K8:8)  //Time
						BLOB TO VARIABLE:C533($Data_blb; $Data_tm; $Offset_l)
						$FieldToUpdate_ptr->:=$Data_tm
						
					: ($Data_blbType_l=Is BLOB:K8:12)  //Blob
						BLOB TO VARIABLE:C533($Data_blb; $xBlob; $Offset_l)
						$FieldToUpdate_ptr->:=$xBlob
						
				End case 
				
			End if 
		End for 
		ut_Message("Set fields ["+Table name:C256([Activity Log:59]File Number:7)+"]"+<>sCR+$ChangedFields_txt+<>sCR)  //No display of data
		
		SAVE RECORD:C53($LocalTable_ptr->)
		
		If (4DError_b)
			C_TEXT:C284($MyTableName_txt)
			$MyTableName_txt:=Table name:C256($LocalTable_ptr)
			If ((Find in array:C230(IgnoreDuplicateKeyTables_atxt; $MyTableName_txt)>0) & ((Find in array:C230(SQLErrorNumbers_al; 1115)>0) | (Find in array:C230(SQLErrorNumbers_al; -9998)>0)))
				//duplicate key error in list of ignore dup key tables - ignore the error and continue
				//the duplicate key will be passed down to DBs downloading from the current DB.
				ut_Message("New record skipped : duplicate key already found "+Table name:C256($LocalTable_ptr)+" "+Field name:C257($LocalFld_ptr)+" = "+$Localid_s+<>sCR)
				4DError_b:=False:C215
			Else 
				//any other error - write the error and don't save act log record
				C_BOOLEAN:C305($OriginalonScreen_b)
				$OriginalonScreen_b:=vbOnScreenMessage
				vbOnScreenMessage:=False:C215
				ut_SQLWriteErrorsToLog("Error creating new local record in table ["+Table name:C256($LocalTable_ptr)+"] ["+Field name:C257($LocalFld_ptr)+"] = "+$Localid_s+<>sCR)
				vbOnScreenMessage:=$OriginalonScreen_b
				SaveActivityLogRecord_b:=False:C215
				
			End if 
		Else 
			ut_Message("New record created table "+Table name:C256($LocalTable_ptr)+" "+Field name:C257($LocalFld_ptr)+" = "+$Localid_s+<>sCR)
			
		End if 
		
		UNLOAD RECORD:C212($LocalTable_ptr->)
		
		If (SaveActivityLogRecord_b)
			//reset in case something has changed
			[Activity Log:59]Local ID:15:=$Localid_s
			[Activity Log:59]Parent ID:14:=$Parentid_s
			SAVE RECORD:C53([Activity Log:59])
		End if 
	Else 
		UNLOAD RECORD:C212([Activity Log:59])
		MissingParent_B:=True:C214
		ut_Message("New record skipped : Parent record did not exist - Child table "+Table name:C256($LocalTable_ptr)+" "+Field name:C257($LocalFld_ptr)+" = "+$Localid_s+" - Parent key  = "+$Parentid_s+<>sCR)
	End if 
Else 
	
	C_BOOLEAN:C305($OriginalonScreen_b)
	$OriginalonScreen_b:=vbOnScreenMessage
	vbOnScreenMessage:=False:C215
	ut_SQLWriteErrorsToLog("Act Log error in "+Current method name:C684+"  -ID"+String:C10([Activity Log:59]RefID:28)+<>sCR)
	vbOnScreenMessage:=$OriginalonScreen_b
	
End if 
//End ut_SQLInitializeLocalRecord