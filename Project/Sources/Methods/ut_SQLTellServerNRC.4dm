//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 05/06/10, 13:56:34
// ----------------------------------------------------
// Method: ut_SQLTellServerNRC
// Description
// <caret/>
//
// Parameters
// ----------------------------------------------------
//ut_SQLTellServerNRC (ActFileID_l;OwnerFileID_l;OwnerRef_l;OwnerName_l)
//$1 is the activity log file id
//$2 is the owner file fileid
//$3 is the field id of the owner file index
//$4 is the field id of the owner name in the owner file
// Modified by: Charles Miller (5/6/10)
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:12:08) 
	//Ugrade to v11
	//Modified by: Charles Miller (4/28/11 17:02:07)
	//Modify how (Not(4DError_b)) and (Not(SQLError_b)) handled replace with (ut_fTestForSQLor4DError)
	//Modified by: Charles Miller (11/4/11 11:17:18)
	Mods_2013_12  // Add ability to skip add record errors for certain tables
	//Modified by: Charles Miller (12/19/13 14:23:30)
	// Modified by: Costas Manousakis-(Designer)-(6/9/14 16:02:52)
	Mods_2014_06_bug
	//  `fixed wrong error code for Duplcate key error - and prevent propagation of NRC  activity to other databases
	// Modified by: Costas Manousakis-(Designer)-(8/7/14 14:22:58)
	Mods_2014_08_bug
	//  `  `mark record as sent here when  ut_SQLUpdateServerActLog will not becalled due to Duplcate key ignore
	
End if 
C_TEXT:C284($0)
SQLError_b:=False:C215
4DError_b:=False:C215


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
	//nothing happens in sql here 
	//get table name from [Activity Log]FileID Local
	//insert table set
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