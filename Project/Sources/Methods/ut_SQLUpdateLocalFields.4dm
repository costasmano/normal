//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 07/13/10, 11:45:05
// ----------------------------------------------------
// Method: ut_SQLUpdateLocalFields
// Description
//ut_SQLUpdateLocalField
// Parameters
// ----------------------------------------------------


// Modified by: Charles Miller (6/28/10)
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:18:17) 
	Mods_2018_05  // Fix issue where we are not checing for locked and loaded record during download 
	//Modified by: Chuck Miller (5/17/18 16:45:49)
End if 

C_TEXT:C284($LocalID_s; $ParentID_s)  // Command Replaced was o_C_STRING length was 80
C_POINTER:C301($LocalTable_ptr)
$LocalTable_ptr:=Table:C252([Activity Log:59]FileID Local:24)

ut_SQLGetCorrectRecord(->$LocalID_s; ->$ParentID_s)
ut_SQLDownLoadLoadRecord($LocalTable_ptr)

If (Records in selection:C76($LocalTable_ptr->)=1)
	If (XFERRecordLoaded_B)
		If (BLOB size:C605([Activity Log:59]Data:10)#0)
			C_LONGINT:C283($Compressed_l)
			C_BLOB:C604($Data_blb)
			SET BLOB SIZE:C606($Data_blb; 0)
			
			$Data_blb:=[Activity Log:59]Data:10
			BLOB PROPERTIES:C536($Data_blb; $Compressed_l)
			If ($Compressed_l#Is not compressed:K22:11)
				EXPAND BLOB:C535($Data_blb)
			End if 
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
							If ($Data_blbType_l=Is alpha field:K8:1)
								$Data_txt:=Old:C35($FieldToUpdate_ptr->)
							Else 
								$Data_txt:=""
							End if 
							VARIABLE TO BLOB:C532($Data_txt; $Old_blb; *)
						: ($Data_blbType_l=Is real:K8:4)  //Real
							BLOB TO VARIABLE:C533($Data_blb; $Data_r; $Offset_l)
							$FieldToUpdate_ptr->:=$Data_r
							$Data_r:=Old:C35($FieldToUpdate_ptr->)
							VARIABLE TO BLOB:C532($Data_r; $Old_blb; *)
						: ($Data_blbType_l=Is picture:K8:10)  //Picture
							BLOB TO VARIABLE:C533($Data_blb; $Data_p; $Offset_l)
							$FieldToUpdate_ptr->:=$Data_p
							$Data_p:=$Data_p*0
							VARIABLE TO BLOB:C532($Data_p; $Old_blb; *)
						: ($Data_blbType_l=Is date:K8:7)  //Date
							BLOB TO VARIABLE:C533($Data_blb; $Data_d; $Offset_l)
							$FieldToUpdate_ptr->:=$Data_d
							$Data_d:=Old:C35($FieldToUpdate_ptr->)
							VARIABLE TO BLOB:C532($Data_d; $Old_blb; *)
						: ($Data_blbType_l=Is boolean:K8:9)  //Boolean
							BLOB TO VARIABLE:C533($Data_blb; $Data_b; $Offset_l)
							$FieldToUpdate_ptr->:=$Data_b
							$Data_b:=Old:C35($FieldToUpdate_ptr->)
							VARIABLE TO BLOB:C532($Data_b; $Old_blb; *)
						: ($Data_blbType_l=Is integer:K8:5) | ($Data_blbType_l=Is longint:K8:6)  //Integer
							BLOB TO VARIABLE:C533($Data_blb; $Data_l; $Offset_l)
							$FieldToUpdate_ptr->:=$Data_l
							$Data_l:=Old:C35($FieldToUpdate_ptr->)
							VARIABLE TO BLOB:C532($Data_l; $Old_blb; *)
						: ($Data_blbType_l=Is time:K8:8)  //Time
							BLOB TO VARIABLE:C533($Data_blb; $Data_tm; $Offset_l)
							$FieldToUpdate_ptr->:=$Data_tm
							$Data_tm:=Old:C35($FieldToUpdate_ptr->)
							VARIABLE TO BLOB:C532($Data_tm; $Old_blb; *)
						: ($Data_blbType_l=Is BLOB:K8:12)  //Blob
							BLOB TO VARIABLE:C533($Data_blb; $xBlob; $Offset_l)
							$FieldToUpdate_ptr->:=$xBlob
							SET BLOB SIZE:C606($xBlob; 0)
							//VARIABLE TO BLOB($xBlob;$xOldStore;*)` do we need this
					End case 
					
					
				End if 
			End for 
			ut_Message("Changed fields ["+Table name:C256([Activity Log:59]File Number:7)+"]"+<>sCR+$ChangedFields_txt+<>sCR)  //No display of data
			
			SAVE RECORD:C53($LocalTable_ptr->)
			
		End if 
		UNLOAD RECORD:C212($LocalTable_ptr->)
		
		[Activity Log:59]Local ID:15:=$LocalID_s
		[Activity Log:59]Parent ID:14:=$ParentID_s
		
		SAVE RECORD:C53([Activity Log:59])
	Else 
		ut_Message("Data Load error! Record Not updated! for table "+Table name:C256($LocalTable_ptr)+" Local ID "+$LocalID_s+<>sCR)
	End if 
Else 
	DataRefernceError_b:=True:C214
	ut_Message("Data reference error! Data ignored!"+<>sCR)
End if 

If (4DError_b)
	C_BOOLEAN:C305($OriginalonScreen_b)
	$OriginalonScreen_b:=vbOnScreenMessage
	vbOnScreenMessage:=False:C215
	ut_SQLWriteErrorsToLog("Act Log error in "+Current method name:C684+"  -ID"+String:C10([Activity Log:59]RefID:28)+<>sCR)
	vbOnScreenMessage:=$OriginalonScreen_b
End if 