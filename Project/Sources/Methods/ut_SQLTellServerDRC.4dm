//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 05/06/10, 16:47:58
// ----------------------------------------------------
// Method: ut_SQLTellServerDRC
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

// Modified by: Charles Miller (5/6/10)
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:12:35) 
	//Ugrade to v11
	//Modified by: Charles Miller (5/10/11 11:28:06)
	//Modify how (Not(4DError_b)) and (Not(SQLError_b)) handled replace with (ut_fTestForSQLor4DError)
	//Modified by: Charles Miller (11/4/11 11:15:24)
End if 


SQLError_b:=False:C215
4DError_b:=False:C215


C_LONGINT:C283($Numrec_l)
C_TEXT:C284($SQLWhereQuery_txt; $SQLSelectQuery_txt)
C_TEXT:C284($TableName_txt)
$SQLSelectQuery_txt:=ut_SQLReturnSelect(->$SQLWhereQuery_txt; ->$TableName_txt)
$Numrec_l:=ut_SQLSelectForLoad($SQLSelectQuery_txt; [Activity Log:59]Local Type:18)

C_TEXT:C284($Upd_FieldName_txt; $UpdTableName_txt)
If (ut_fTestForSQLor4DError) & (RecordLocked_b)
	If ($Numrec_l=1)
		If (ut_SQLDeleteRecord($Numrec_l; $TableName_txt; $SQLWhereQuery_txt))
			DeletionOK_b:=True:C214
		Else 
			DeletionOK_b:=False:C215
		End if 
	Else 
		
		If ($Numrec_l>1)
			ut_Message("More than one record returned - see log")
		Else 
			ut_Message("Zero records returned - see log")
		End if 
		C_BOOLEAN:C305($OriginalonScreen_b)
		$OriginalonScreen_b:=vbOnScreenMessage
		ut_Message("The record count for the following select was "+String:C10($Numrec_l))
		ut_Message($SQLSelectQuery_txt)
		vbOnScreenMessage:=$OriginalonScreen_b
		
		//ut_SQLUpdateServerActLog 
	End if 
End if 




