//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 07/22/10, 10:45:56
// ----------------------------------------------------
// Method: ut_SQLServerLink
// Description
// <caret/>
//
// Parameters
// ----------------------------------------------------



// Modified by: Charles Miller (7/22/10)
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:18:43) 
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
		C_POINTER:C301($FieldToUpdate_ptr)
		C_TEXT:C284($Data_txt)
		C_DATE:C307($Data_d)
		C_TIME:C306($Data_tm)
		C_LONGINT:C283($Data_l)
		C_REAL:C285($Data_r)
		C_PICTURE:C286($Data_p)
		C_BOOLEAN:C305($Data_b)
		C_LONGINT:C283($Offset_l)
		$Offset_l:=0
		C_TEXT:C284($NewData_txt)
		C_LONGINT:C283($NewData_l)
		$FieldToUpdate_ptr:=Field:C253([Activity Log:59]File Number:7; [Activity Log:59]Field Number:8)  //point to the data
		C_TEXT:C284($LookupValue_s; $LookupValue1_s)  // Command Replaced was o_C_STRING length was 80
		C_LONGINT:C283($BlobSize_l; $Compressed_l)
		C_BLOB:C604($Data_blb)
		$Data_blb:=[Activity Log:59]Data:10
		BLOB PROPERTIES:C536($Data_blb; $Compressed_l)
		If ($Compressed_l#Is not compressed:K22:11)
			EXPAND BLOB:C535($Data_blb)
		End if 
		$BlobSize_l:=BLOB size:C605($Data_blb)
		
		Case of   //first case to get the Linked ID 
			: ($BlobSize_l=0)
				
			: ([Activity Log:59]Data Type:11=Is alpha field:K8:1) | ([Activity Log:59]Data Type:11=Is text:K8:3)  //Alpha
				BLOB TO VARIABLE:C533($Data_blb; $NewData_txt; $Offset_l)
				$LookupValue_s:=$NewData_txt
			: ([Activity Log:59]Data Type:11=Is integer:K8:5) | ([Activity Log:59]Data Type:11=Is longint:K8:6)
				BLOB TO VARIABLE:C533($Data_blb; $NewData_l; $Offset_l)
				$LookupValue_s:=String:C10($NewData_l)
				
		End case 
		//get the Linked table number
		C_LONGINT:C283($Tablenumber)
		BLOB TO VARIABLE:C533($Data_blb; $Tablenumber; $Offset_l)
		If (($Tablenumber=0) | (OK=0))
			$Tablenumber:=[Activity Log:59]File Number:7
			Case of 
				: ([Activity Log:59]ActField Name:20="NBISInspID")
					$Tablenumber:=Table:C252(->[Inspections:27])
				: ([Activity Log:59]ActField Name:20="BMSInspID")
					$Tablenumber:=Table:C252(->[BMS Inspections:44])
			End case 
			
		End if   //find the remote related ID
		$LookupValue_s:=aDblLookUpDest($Tablenumber; $LookupValue_s; "here"; <>Destination)
		//if found values - assign them
		If ($LookupValue_s="")
		Else 
			
			Case of 
				: ([Activity Log:59]Data Type:11=Is alpha field:K8:1) | ([Activity Log:59]Data Type:11=Is text:K8:3)
					$NewData_txt:=$LookupValue_s
				: ([Activity Log:59]Data Type:11=Is integer:K8:5) | ([Activity Log:59]Data Type:11=Is longint:K8:6)
					$NewData_l:=Num:C11($LookupValue_s)
					
			End case 
			
		End if 
		
		//assign values to the field
		Case of 
			: ([Activity Log:59]Data Type:11=Is alpha field:K8:1) | ([Activity Log:59]Data Type:11=Is text:K8:3)
				$Data_txt:=$FieldToUpdate_ptr->
				$FieldToUpdate_ptr->:=$NewData_txt
				VARIABLE TO BLOB:C532($Data_txt; [Activity Log:59]Old Data:27)
				VARIABLE TO BLOB:C532($NewData_txt; [Activity Log:59]Data:10)
			: ([Activity Log:59]Data Type:11=Is integer:K8:5) | ([Activity Log:59]Data Type:11=Is longint:K8:6)
				$Data_l:=$FieldToUpdate_ptr->
				$FieldToUpdate_ptr->:=$NewData_l
				VARIABLE TO BLOB:C532($Data_l; [Activity Log:59]Old Data:27)
				VARIABLE TO BLOB:C532($NewData_l; [Activity Log:59]Data:10)
				
		End case 
		VARIABLE TO BLOB:C532($Tablenumber; [Activity Log:59]Data:10; *)
		
		[Activity Log:59]Local ID:15:=$LocalID_s
		[Activity Log:59]Parent ID:14:=$ParentID_s
		
		
		ut_Message("Linked Field=["+Table name:C256([Activity Log:59]File Number:7)+"]"+[Activity Log:59]ActField Name:20+<>sCR)  //No display of data
		ut_Message("Updating record…"+<>sCR)
		SAVE RECORD:C53($LocalTable_ptr->)
		UNLOAD RECORD:C212($LocalTable_ptr->)
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