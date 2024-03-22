//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 04/20/10, 10:45:05
// ----------------------------------------------------
// Method: ut_SQLUpdateServerActLog
// Description
// ut_SQLUpdateServerActLog 

//
// Parameters
// ----------------------------------------------------

If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:58:45)
	//Ugrade to v11
	//Modified by: Charles Miller (4/28/11 17:02:22)
	//Ugrade to v11
	//Modified by: Charles Miller (5/3/11 12:21:12)
	//Modify how (Not(4DError_b)) and (Not(SQLError_b)) handled replace with (ut_fTestForSQLor4DError)
	//Modified by: Charles Miller (11/4/11 11:17:42)
	Mods_2011_11  //Fix bug where incorrect ref id sent to server
	//Modified by: Charles Miller (11/21/11 14:41:20)
	Mods_2011_11  //added code to zero out blobs NewFieldID and OldFieldID
	//Modified by: Charles Miller (11/23/11 15:56:26)
	// Modified by: Costas Manousakis-(Designer)-(6/8/20 15:21:45)
	Mods_2020_06
	//  `do not send the UUID field - CallReference #717
End if 
C_LONGINT:C283($TableNumber_l)
$TableNumber_l:=Table:C252(->[Activity Log:59])

[Activity Log:59]Status:9:=1
SAVE RECORD:C53([Activity Log:59])

//Transfer=0 Send
//Transfer=1 Send,Forward
//Create an activity record on the server
//Temporarily set these for values for the server side activity record
If ([Activity Log:59]Transfer:12=1)  //Prepare to send this information again. Do a forward
	[Activity Log:59]Destination:1:=[Activity Log:59]Forward:13
	[Activity Log:59]Forward:13:=""
	[Activity Log:59]Transfer:12:=0  //Downgrade this to a send
	[Activity Log:59]Status:9:=0  //Reset this to unsent
Else   //This is just a normal record. No forwarding.
	[Activity Log:59]Destination:1:=""
End if 
Case of 
	: ([Activity Log:59]RefIDType:26=0)
		//Do nothing
	: ([Activity Log:59]RefIDType:26=1)
		[Activity Log:59]Local ID:15:=[Activity Log:59]Dest ID local:19
		[Activity Log:59]Dest ID local:19:=""
	: ([Activity Log:59]RefIDType:26=2)
		[Activity Log:59]Parent ID:14:=[Activity Log:59]Dest ID parent:16
		[Activity Log:59]Local ID:15:=[Activity Log:59]Dest ID local:19
		[Activity Log:59]Dest ID parent:16:=""
		[Activity Log:59]Dest ID local:19:=""
	: ([Activity Log:59]RefIDType:26=3)
		[Activity Log:59]Parent ID:14:=[Activity Log:59]Dest ID parent:16
		[Activity Log:59]Local ID:15:=[Activity Log:59]Dest ID local:19
		[Activity Log:59]Dest ID parent:16:=""
		[Activity Log:59]Dest ID local:19:=""
	: ([Activity Log:59]RefIDType:26=4)
		[Activity Log:59]Parent ID:14:=""
		[Activity Log:59]Local ID:15:=[Activity Log:59]Dest ID local:19
		[Activity Log:59]Dest ID parent:16:=""
		[Activity Log:59]Dest ID local:19:=""
End case 

If ([Activity Log:59]Activity Type:3="LNK") | ([Activity Log:59]Activity Type:3="GRD")
	[Activity Log:59]Data:10:=NewFieldID
	[Activity Log:59]Old Data:27:=OldFieldID
End if 
//Get a reference ID for the remote server
RELATE MANY:C262([Activity Log:59])
[Activity Log:59]RefID:28:=RemoteActivityID_l
//[Activity Log]RefID:=SQL_RetrieveNextID ("Activity Log")

If (ut_fTestForSQLor4DError)
	Compiler_FieldVariables(Table:C252(->[Activity Log:59]))
	clone_ClearFieldVariables(Table:C252(->[Activity Log:59]))
	C_TEXT:C284($InsertFieldName_txt; $InsertFieldBind_txt; $SQL_Fields_txt; $SQL_Values_txt; $SQL_Insert_txt; $SQL_Fields_txt; $SQL_Values_txt)
	
	$SQL_Insert_txt:="INSERT INTO [Activity Log] "
	$SQL_Fields_txt:=""
	$SQL_Values_txt:=""
	C_LONGINT:C283($Loop_l; $RecordCount_l)
	For ($Loop_l; 1; Get last field number:C255($TableNumber_l))
		If (Is field number valid:C1000($TableNumber_l; $Loop_l))
			ut_SQLReturnFromFileForSQL($TableNumber_l; $Loop_l; ->$InsertFieldName_txt; ->$InsertFieldBind_txt)
			If (($InsertFieldName_txt#"") & ($InsertFieldName_txt#"@UUID@"))
				If ($SQL_Fields_txt="")
					$SQL_Fields_txt:="("+$InsertFieldName_txt
					$SQL_Values_txt:="(:"+$InsertFieldBind_txt
				Else 
					$SQL_Fields_txt:=$SQL_Fields_txt+", "+$InsertFieldName_txt
					$SQL_Values_txt:=$SQL_Values_txt+",:"+$InsertFieldBind_txt
				End if 
			End if 
		End if 
	End for 
	
	
	$SQL_Insert_txt:=$SQL_Insert_txt+Char:C90(Carriage return:K15:38)+$SQL_Fields_txt+")"+Char:C90(Carriage return:K15:38)+"VALUES "+$SQL_Values_txt+");"+Char:C90(Carriage return:K15:38)
	
	For ($Loop_l; 1; Get last field number:C255($TableNumber_l))
		If (Is field number valid:C1000($TableNumber_l; $Loop_l))
			If (TableFidTypes_al{$TableNumber_l}{$Loop_l}#7)  //type 7 is subtable we are not using any data from them
				TableFieldsVars_aptr{$TableNumber_l}{$Loop_l}->:=TableFlds_aptr{$TableNumber_l}{$Loop_l}->
			End if 
		End if 
	End for 
	// no need as code is short ut_SQLSetVarsForRemoteUpdate (59) replaced with code directly above
	
	ON ERR CALL:C155("SQL_ERROR")  //
	SQL_text:=$SQL_Insert_txt
	//SQL EXECUTE(SQL_text)
	//SQL CANCEL LOAD
	
	
	Begin SQL
		EXECUTE IMMEDIATE :SQL_text;
	End SQL
	
	
	ON ERR CALL:C155("4D_Errors")
	If (ut_fTestForSQLor4DError)
		//Let's create owners of data records
		//QUERY([Owners of Data];[Owners of Data]RefID=[Activity Log]RefID)
		
		$RecordCount_l:=Records in selection:C76([Owners of Data:62])
		
		$SQL_Insert_txt:="INSERT INTO [Owners of Data] (RefID, [Owner Name]) VALUES (:REFIDs_al, :REFOwners_as);"
		C_BOOLEAN:C305($OriginalonScreen_b)
		$OriginalonScreen_b:=vbOnScreenMessage
		
		
		ARRAY LONGINT:C221(REFIDs_al; 0)
		ARRAY TEXT:C222(REFOwners_as; 0)  //Command Replaced was o_ARRAY string length was 80
		ARRAY LONGINT:C221(REFIDs_al; $RecordCount_l)
		ARRAY TEXT:C222(REFOwners_as; $RecordCount_l)  //Command Replaced was o_ARRAY string length was 80
		
		SELECTION RANGE TO ARRAY:C368(1; $RecordCount_l; [Owners of Data:62]Owner Name:2; REFOwners_as)
		APPEND TO ARRAY:C911(REFIDs_al; 0)
		APPEND TO ARRAY:C911(REFOwners_as; <>CurrentUser_Name)
		ON ERR CALL:C155("SQL_ERROR")  //
		
		For ($Loop_l; 1; Size of array:C274(REFIDs_al))
			REFIDs_al{$Loop_l}:=RemoteActivityID_l
		End for 
		
		SQL EXECUTE:C820($SQL_Insert_txt)
		SQL CANCEL LOAD:C824
		
		
		ON ERR CALL:C155("4D_Errors")
		If (SQLError_b) | (4DError_b)
			ut_SQLWriteErrorsToLog("Act Log error in insert "+Current method name:C684+" updating [Owners of Data] records -ID "+String:C10([Activity Log:59]RefID:28)+<>sCR)
			vbOnScreenMessage:=False:C215
			ut_SQLWriteErrorsToLog($SQL_Insert_txt+<>sCR)
			
		End if 
	Else 
		ut_SQLWriteErrorsToLog("Act Log error in insert "+Current method name:C684+" updating [Activity Log] records -ID "+String:C10([Activity Log:59]RefID:28)+<>sCR)
		vbOnScreenMessage:=False:C215
		ut_SQLWriteErrorsToLog($SQL_Insert_txt+<>sCR)
		
	End if 
Else 
	
	ut_SQLWriteErrorsToLog("Error in retrieveing next ID "+Current method name:C684+" [Activity Log] records -ID "+String:C10([Activity Log:59]RefID:28)+<>sCR)
End if 
vbOnScreenMessage:=$OriginalonScreen_b

SET BLOB SIZE:C606(NewFieldID; 0)
SET BLOB SIZE:C606(OldFieldID; 0)