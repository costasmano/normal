//%attributes = {"invisible":true}
// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 07/13/10, 15:39:39
// ----------------------------------------------------
// Method: ut_SQLDeleteLocalRecords
// Description

// Parameters
// ----------------------------------------------------
// Modified by: Charles Miller (7/8/10)

If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:18:32) 
	//Fix delete bug and alert how $0 is returned
	//Modified by: Charles Miller (11/4/11 10:31:58)
	// Modified by: Costas Manousakis-(Designer)-(1/30/14 13:23:07)
	Mods_2014_01
	//  `Fixed bug where the parentfield pointer was not the correct field for refIDType=1
	Mods_2016_01_bug  //   `FIX BUG WHERE [Activity Log] records were being created where they should not have been  
	//Modified by: administrator (1/5/16 14:16:58)
End if 

C_LONGINT:C283($RefID_l)

C_TEXT:C284($RefID_s; $ParentID_s; $LocalID_s)  // Command Replaced was o_C_STRING length was 80
C_POINTER:C301($LocalTable_ptr; $LocalFld_ptr)
$LocalTable_ptr:=Table:C252([Activity Log:59]FileID Local:24)
$LocalFld_ptr:=Field:C253([Activity Log:59]FileID Local:24; [Activity Log:59]FieldID Local:25)
C_BLOB:C604($Data_blb)
SET BLOB SIZE:C606($Data_blb; 0)
C_LONGINT:C283($BlobSize_l; $Compressed_l; $NumRecIDs_l; $i)
$BlobSize_l:=BLOB size:C605([Activity Log:59]Data:10)

COPY BLOB:C558([Activity Log:59]Data:10; $Data_blb; 0x0000; 0x0000; $BlobSize_l)

BLOB PROPERTIES:C536([Activity Log:59]Data:10; $Compressed_l)
If ($Compressed_l#Is not compressed:K22:11)
	EXPAND BLOB:C535($Data_blb)
End if 
C_LONGINT:C283($NumFlds_l; $Offset_l; $Loop_l; $FieldNumber_l)
C_LONGINT:C283($NumRecIDs)
ARRAY TEXT:C222($RecIDToDelete_as; 0)  //Command Replaced was o_ARRAY string length was 80
ARRAY LONGINT:C221($RecIDToDelete_al; 0)
BLOB TO VARIABLE:C533($Data_blb; $RecIDToDelete_as)
$NumRecIDs_l:=Size of array:C274($RecIDToDelete_as)
ARRAY LONGINT:C221($RecIDToDelete_al; 0)
ARRAY LONGINT:C221($RecIDToDelete_al; $NumRecIDs_l)

For ($i; 1; $NumRecIDs_l)
	If ([Activity Log:59]RefIDType:26=3)
		$RecIDToDelete_as{$i}:=aDblLookUpDest([Activity Log:59]File Number:7; $RecIDToDelete_as{$i}; "here"; <>Destination)
	Else 
		$RecIDToDelete_as{$i}:=aDblLookUpDest([Activity Log:59]FileID Local:24; $RecIDToDelete_as{$i}; "here"; <>Destination)
	End if 
	
	$RecIDToDelete_al{$i}:=Num:C11($RecIDToDelete_as{$i})
End for 
ut_Message("Searching for "+String:C10($NumRecIDs_l)+" records in table "+Table name:C256($LocalTable_ptr)+"..."+<>sCR)
If ([Activity Log:59]RefIDType:26=0)
	QUERY WITH ARRAY:C644($LocalFld_ptr->; $RecIDToDelete_as)
Else 
	QUERY WITH ARRAY:C644($LocalFld_ptr->; $RecIDToDelete_al)
End if 
ARRAY TEXT:C222($RecIDToDelete_as; 0)  //Command Replaced was o_ARRAY string length was 80
ARRAY LONGINT:C221($RecIDToDelete_al; 0)
C_POINTER:C301($ParentField_ptr)

Case of 
	: ([Activity Log:59]RefIDType:26=0)
		
	: ([Activity Log:59]RefIDType:26=1)
		
		$ParentID_s:=[Activity Log:59]Parent ID:14
		
		$RefID_l:=Num:C11([Activity Log:59]Parent ID:14)
		$ParentField_ptr:=Field:C253([Activity Log:59]FileID Local:24; [Activity Log:59]FieldID Parent:23)
		If ([Activity Log:59]Type Parent:17=0)
			QUERY SELECTION:C341($LocalTable_ptr->; $ParentField_ptr->=[Activity Log:59]Parent ID:14)
		Else 
			QUERY SELECTION:C341($LocalTable_ptr->; $ParentField_ptr->=$RefID_l)
		End if 
		
		
	: ([Activity Log:59]RefIDType:26=2)
		
		$RefID_s:=aDblLookUpDest([Activity Log:59]FileID Parent:22; [Activity Log:59]Parent ID:14; "Here"; <>Destination)
		
		$ParentField_ptr:=Field:C253([Activity Log:59]FileID Local:24; [Activity Log:59]FieldID Parent:23)
		If ([Activity Log:59]Type Parent:17=0)
			QUERY SELECTION:C341($LocalTable_ptr->; $ParentField_ptr->=$RefID_s)
		Else 
			$RefID_l:=Num:C11($RefID_s)
			QUERY SELECTION:C341($LocalTable_ptr->; $ParentField_ptr->=$RefID_l)
		End if 
		$ParentID_s:=$RefID_s
	: ([Activity Log:59]RefIDType:26=3)
		
		$RefID_s:=aLookUpDest([Activity Log:59]FileID Parent:22; [Activity Log:59]Parent ID:14; "here")  //Can not rely on the destination id
		//Danger!             
		If ($RefID_s="")  //Assume remote and local ids match!
			$RefID_s:=[Activity Log:59]Parent ID:14
		End if 
		$RefID_l:=Num:C11($RefID_s)
		$LocalFld_ptr:=Field:C253([Activity Log:59]FileID Local:24; [Activity Log:59]FieldID Parent:23)
		If ([Activity Log:59]Type Parent:17=0)
			QUERY SELECTION:C341($LocalTable_ptr->; $LocalFld_ptr->=$RefID_s)
		Else 
			QUERY SELECTION:C341($LocalTable_ptr->; $LocalFld_ptr->=$RefID_l)
		End if 
		$ParentID_s:=$RefID_s
		
		
End case 

ut_Message("Found "+String:C10(Records in selection:C76($LocalTable_ptr->))+" Records.."+<>sCR)

If ((Records in selection:C76($LocalTable_ptr->)<=$NumRecIDs_l) & (Records in selection:C76($LocalTable_ptr->)>0))
	$NumRecIDs_l:=Records in selection:C76($LocalTable_ptr->)
	If ([Activity Log:59]RefIDType:26=0)
		SELECTION TO ARRAY:C260($LocalFld_ptr->; $RecIDToDelete_as)
	Else 
		SELECTION TO ARRAY:C260($LocalFld_ptr->; $RecIDToDelete_al)
		ARRAY TEXT:C222($RecIDToDelete_as; $NumRecIDs_l)  //Command Replaced was o_ARRAY string length was 80
		For ($i; 1; $NumRecIDs_l)
			$RecIDToDelete_as{$i}:=String:C10($RecIDToDelete_al{$i})
		End for 
	End if 
	
	SET BLOB SIZE:C606([Activity Log:59]Data:10; 0)
	VARIABLE TO BLOB:C532($RecIDToDelete_as; [Activity Log:59]Data:10)
	SET BLOB SIZE:C606([Activity Log:59]Old Data:27; 0)
	VARIABLE TO BLOB:C532($RecIDToDelete_as; [Activity Log:59]Old Data:27)
	C_LONGINT:C283($Count_l)
	$Count_l:=0
	If (Records in selection:C76($LocalTable_ptr->)=0)
		SaveActivityLogRecord_b:=False:C215
	Else 
		Repeat 
			DELETE SELECTION:C66($LocalTable_ptr->)
			
			If (Records in set:C195("LockedSet")>0)
				IDLE:C311
				DELAY PROCESS:C323(Current process:C322; 60)
				$Count_l:=$Count_l+1
				USE SET:C118("LockedSet")
			End if 
		Until ($Count_l>10) | (Records in set:C195("LockedSet")=0)
		If (Records in set:C195("LockedSet")>0)
			ut_Message("Some records in table "+Table name:C256($LocalTable_ptr)+" are locked. Canceling Deletion.."+<>sCR)
			DeletionOK_b:=False:C215
		Else 
			ut_Message("Deleted "+String:C10($NumRecIDs_l)+" Records in table "+Table name:C256($LocalTable_ptr)+" .."+<>sCR)
			DeletionOK_b:=True:C214
			
			[Activity Log:59]Parent ID:14:=$ParentID_s
			SAVE RECORD:C53([Activity Log:59])
		End if 
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
ARRAY TEXT:C222($RecIDToDelete_as; 0)  //Command Replaced was o_ARRAY string length was 80
ARRAY LONGINT:C221($RecIDToDelete_al; 0)
