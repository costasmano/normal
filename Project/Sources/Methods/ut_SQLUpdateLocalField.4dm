//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 06/28/10, 14:02:46
// ----------------------------------------------------
// Method: ut_SQLUpdateLocalField
// Description
// <caret/>
//ut_SQLUpdateLocalField 
// Parameters
// ----------------------------------------------------



// Modified by: Charles Miller (6/28/10)
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:17:14) 
	Mods_2018_05  // Fix issue where we are not checing for locked and loaded record during download 
	//Modified by: Chuck Miller (5/17/18 16:45:49)
End if 

C_TEXT:C284($LocalID_s; $ParentID_s)  // Command Replaced was o_C_STRING length was 80


C_POINTER:C301($LocalTable_ptr; $LocalFld_ptr)
$LocalTable_ptr:=Table:C252([Activity Log:59]FileID Local:24)
ut_SQLGetCorrectRecord(->$LocalID_s; ->$ParentID_s)

ut_SQLDownLoadLoadRecord($LocalTable_ptr)


If (Records in selection:C76($LocalTable_ptr->)=1)
	If (XFERRecordLoaded_B)
		C_LONGINT:C283($vlActDataTyp_Check)
		C_TEXT:C284($vsActFldName_check)  // Command Replaced was o_C_STRING length was 80
		$vlActDataTyp_Check:=-1
		$vsActFldName_check:=""
		If ([Activity Log:59]Field Number:8<=Get last field number:C255([Activity Log:59]File Number:7))
			GET FIELD PROPERTIES:C258([Activity Log:59]File Number:7; [Activity Log:59]Field Number:8; $vlActDataTyp_Check)
			$vsActFldName_check:=Field name:C257([Activity Log:59]File Number:7; [Activity Log:59]Field Number:8)
		End if 
		If (([Activity Log:59]ActField Name:20#$vsActFldName_check) | ($vlActDataTyp_Check#[Activity Log:59]Data Type:11))
			ut_Message(".. Field=["+Table name:C256([Activity Log:59]File Number:7)+"]"+[Activity Log:59]ActField Name:20+" Not in local DB!"+<>sCR)
			UNLOAD RECORD:C212($LocalTable_ptr->)
		Else 
			C_POINTER:C301($FieldToUpdate_ptr)
			C_TEXT:C284($Data_txt)
			C_DATE:C307($Data_d)
			C_TIME:C306($Data_tm)
			C_LONGINT:C283($Data_l)
			C_REAL:C285($Data_r)
			C_PICTURE:C286($Data_p)
			C_BOOLEAN:C305($Data_b)
			If ([Activity Log:59]Field Number:8<=Get last field number:C255([Activity Log:59]File Number:7))
				If ([Activity Log:59]Data Type:11=TableFidTypes_al{[Activity Log:59]File Number:7}{[Activity Log:59]Field Number:8})
					$FieldToUpdate_ptr:=Field:C253([Activity Log:59]File Number:7; [Activity Log:59]Field Number:8)  //point to the data
					Case of 
						: (BLOB size:C605([Activity Log:59]Data:10)=0)
							
						: ([Activity Log:59]Data Type:11=Is alpha field:K8:1) | ([Activity Log:59]Data Type:11=Is text:K8:3)  //Alpha
							BLOB TO VARIABLE:C533([Activity Log:59]Data:10; $Data_txt)
							$FieldToUpdate_ptr->:=$Data_txt
						: ([Activity Log:59]Data Type:11=Is real:K8:4)  //Real
							BLOB TO VARIABLE:C533([Activity Log:59]Data:10; $Data_r)
							$FieldToUpdate_ptr->:=$Data_r
							
						: ([Activity Log:59]Data Type:11=Is picture:K8:10)  //Picture
							BLOB TO VARIABLE:C533([Activity Log:59]Data:10; $Data_p)
							$FieldToUpdate_ptr->:=$Data_p
						: ([Activity Log:59]Data Type:11=Is date:K8:7)  //Date
							BLOB TO VARIABLE:C533([Activity Log:59]Data:10; $Data_d)
							$FieldToUpdate_ptr->:=$Data_d
						: ([Activity Log:59]Data Type:11=Is boolean:K8:9)  //Boolean
							BLOB TO VARIABLE:C533([Activity Log:59]Data:10; $Data_b)
							$FieldToUpdate_ptr->:=$Data_b
						: ([Activity Log:59]Data Type:11=Is integer:K8:5) | ([Activity Log:59]Data Type:11=Is longint:K8:6)  //Integer
							BLOB TO VARIABLE:C533([Activity Log:59]Data:10; $Data_l)
							$FieldToUpdate_ptr->:=$Data_l
						: ([Activity Log:59]Data Type:11=Is time:K8:8)  //Time
							BLOB TO VARIABLE:C533([Activity Log:59]Data:10; $Data_tm)
							$FieldToUpdate_ptr->:=$Data_tm
						: ([Activity Log:59]Data Type:11=Is BLOB:K8:12)  //Blob
							$FieldToUpdate_ptr->:=[Activity Log:59]Data:10
					End case 
					ut_Message("Field=["+Table name:C256([Activity Log:59]File Number:7)+"]"+[Activity Log:59]ActField Name:20+<>sCR)  //No display of data
					ut_Message("Updating record…"+<>sCR)
					//Log this transaction on the client
				Else 
					ut_Message("Field=["+Table name:C256([Activity Log:59]File Number:7)+"]"+[Activity Log:59]ActField Name:20+<>sCR)  //No display of data
					
					ut_Message("Type mismatch remote field is type "+String:C10([Activity Log:59]Data Type:11)+" local type is "+String:C10(TableFidTypes_al{[Activity Log:59]File Number:7}{[Activity Log:59]Field Number:8})+<>sCR)  //No display of data
					
				End if 
			Else 
				ut_Message("Field number"+String:C10([Activity Log:59]Field Number:8)+" named "+[Activity Log:59]ActField Name:20+" for file ["+Table name:C256([Activity Log:59]File Number:7)+"] does not exists in the local table..."+<>sCR)  //No display of data
				
			End if 
			
			
			
			If (Not:C34(4DError_b))
				//in following case removed checking for Text, Pic, Blob.
				Case of 
					: (BLOB size:C605([Activity Log:59]Data:10)=0)
						
					: ([Activity Log:59]Data Type:11=Is alpha field:K8:1) | ([Activity Log:59]Data Type:11=Is text:K8:3)  //Alpha
						$Data_txt:=Old:C35($FieldToUpdate_ptr->)
						VARIABLE TO BLOB:C532($Data_txt; [Activity Log:59]Old Data:27)
					: ([Activity Log:59]Data Type:11=Is real:K8:4)  //Real
						$Data_r:=Old:C35($FieldToUpdate_ptr->)
						VARIABLE TO BLOB:C532($Data_r; [Activity Log:59]Old Data:27)
						
					: ([Activity Log:59]Data Type:11=Is picture:K8:10)  //Picture
						$Data_p:=Old:C35($FieldToUpdate_ptr->)
						VARIABLE TO BLOB:C532($Data_p; [Activity Log:59]Old Data:27)
					: ([Activity Log:59]Data Type:11=Is date:K8:7)  //Date
						$Data_d:=Old:C35($FieldToUpdate_ptr->)
						VARIABLE TO BLOB:C532($Data_d; [Activity Log:59]Old Data:27)
					: ([Activity Log:59]Data Type:11=Is boolean:K8:9)  //Boolean
						$Data_b:=Old:C35($FieldToUpdate_ptr->)
						VARIABLE TO BLOB:C532($Data_b; [Activity Log:59]Old Data:27)
					: ([Activity Log:59]Data Type:11=Is integer:K8:5) | ([Activity Log:59]Data Type:11=Is longint:K8:6)  //Integer
						$Data_l:=Old:C35($FieldToUpdate_ptr->)
						VARIABLE TO BLOB:C532($Data_l; [Activity Log:59]Old Data:27)
					: ([Activity Log:59]Data Type:11=Is time:K8:8)  //Time
						$Data_tm:=Old:C35($FieldToUpdate_ptr->)
						VARIABLE TO BLOB:C532($Data_tm; [Activity Log:59]Old Data:27)
						
				End case 
				If (BLOB size:C605([Activity Log:59]Data:10)#0)
					SAVE RECORD:C53($LocalTable_ptr->)
				End if 
				UNLOAD RECORD:C212($LocalTable_ptr->)
				
				[Activity Log:59]Local ID:15:=$LocalID_s
				[Activity Log:59]Parent ID:14:=$ParentID_s
				
				SAVE RECORD:C53([Activity Log:59])
				
				
				
			Else 
				
				C_BOOLEAN:C305($OriginalonScreen_b)
				$OriginalonScreen_b:=vbOnScreenMessage
				vbOnScreenMessage:=False:C215
				ut_SQLWriteErrorsToLog("Act Log error in "+Current method name:C684+"  -ID"+String:C10([Activity Log:59]RefID:28)+<>sCR)
				vbOnScreenMessage:=$OriginalonScreen_b
				
			End if 
		End if 
		
	Else 
		ut_Message("Data Load error! Record Not updated for table "+Table name:C256($LocalTable_ptr)+" Local ID "+$LocalID_s+<>sCR)
	End if 
	
Else 
	DataRefernceError_b:=True:C214
	ut_Message("Data reference error! Data ignored!"+<>sCR)
End if 
