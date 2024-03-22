//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 07/08/10, 11:28:33
// ----------------------------------------------------
// Method: ut_SQLCreateNewRecord
// Description
// <caret/>
//ut_SQLCreateNewRecord
// Parameters
// ----------------------------------------------------
// Modified by: Charles Miller (7/8/10)
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:17:31) 
	Mods_2012_02  //r001 Add copde to set SaveActivityLogRecord_b to true at start
	//Modified by: Charles Miller (2/7/12 12:47:07)
	Mods_2013_01  //r001 ` Change way ut_ReturnKeyFldandVariable is called by adding reindex boolean as 5th parameter
	//It should only be passed as true if re-index will occur later using KeysToReset_aptr array
	//Modified by: Charles Miller (2/5/13 13:55:58)
	Mods_2013_12  // Add ability to skip add record errors for certain tables
	//Modified by: Charles Miller (12/19/13 14:23:30)
	// Modified by: Costas Manousakis-(Designer)-(6/10/14 17:46:29)
	Mods_2014_06_bug
	//  `Fixed the error code used when checking for duplicate key error.  Catch any other errors. if table is not on ignrore list , or not a duplicate key error.
	//  `Added writing of the error stack at that point also.
	Mods_2016_01_bug  //   `FIX BUG WHERE [Activity Log] records were being created where they should not have been
	//Modified by: administrator (1/5/16 14:16:58)
End if 

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