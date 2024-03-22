//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 02/25/10, 11:44:46
// ----------------------------------------------------
// Method: ut_SQLTellServerField
// Description
// ut_SQLTellServerField

//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:58:59)
	//Ugrade to v11
	//Modified by: Charles Miller (5/3/11 12:13:23)
	//Ugrade to v11
	//Modified by: Charles Miller (5/3/11 17:14:47)
	//Ugrade to v11
	//Modified by: Charles Miller (5/10/11 11:28:23)
	//Modify how (Not(4DError_b)) and (Not(SQLError_b)) handled replace with (ut_fTestForSQLor4DError)
	//Modified by: Charles Miller (11/4/11 11:16:00)
	//Mods_2011_11 `Make sure to use lStuff (long) instead of iStuff (Integer)
	//Modified by: Charles Miller (11/23/11 15:54:18)
	Mods_2012_02  //r003 `Fix bug to make sure 0 picture size is never sent over
	//Modified by: Charles Miller (2/21/12 16:25:01)
	
End if 


SET BLOB SIZE:C606(NewFieldID; 0)
SET BLOB SIZE:C606(OldFieldID; 0)
C_TEXT:C284($SQLSelectQuery_txt; $SQLUpdate_txt)
C_LONGINT:C283($j; $n; $Numrec_l)

SQLError_b:=False:C215
4DError_b:=False:C215
C_TEXT:C284($SQLWhereQuery_txt)
$SQLSelectQuery_txt:=ut_SQLReturnSelect(->$SQLWhereQuery_txt)
C_LONGINT:C283($vlOffset)
$vlOffset:=0
$Numrec_l:=ut_SQLSelectForLoad($SQLSelectQuery_txt; [Activity Log:59]Local Type:18)
C_BOOLEAN:C305($OriginalonScreen_b)
$OriginalonScreen_b:=vbOnScreenMessage
C_TEXT:C284($Upd_FieldName_txt; $UpdTableName_txt)
If ($Numrec_l=1) & (ut_fTestForSQLor4DError) & (RecordLocked_b)  //Make sure we just found one record!
	//Convert data   
	C_TEXT:C284($vLookupValue_S)  // Command Replaced was o_C_STRING length was 80
	SQL_utReturnStrings([Activity Log:59]File Number:7; [Activity Log:59]Field Number:8; ->$Upd_FieldName_txt; ->$UpdTableName_txt)
	$SQLUpdate_txt:="UPDATE "+$UpdTableName_txt+" SET "+$Upd_FieldName_txt+" = "
	Case of 
		: ([Activity Log:59]Data Type:11=Is alpha field:K8:1)  //Alpha
			BLOB TO VARIABLE:C533([Activity Log:59]Data:10; aStuff; $vlOffset)
			$SQLUpdate_txt:=$SQLUpdate_txt+":aStuff"
			$vLookupValue_S:=aStuff
			VARIABLE TO BLOB:C532(aStuff; OldFieldID)
			
		: ([Activity Log:59]Data Type:11=Is real:K8:4)  //Real
			BLOB TO VARIABLE:C533([Activity Log:59]Data:10; rStuff; $vlOffset)
			$SQLUpdate_txt:=$SQLUpdate_txt+":rStuff"
		: ([Activity Log:59]Data Type:11=Is text:K8:3)  //Text
			BLOB TO VARIABLE:C533([Activity Log:59]Data:10; tStuff; $vlOffset)
			$SQLUpdate_txt:=$SQLUpdate_txt+":tStuff"
		: ([Activity Log:59]Data Type:11=Is picture:K8:10)  //Picture
			BLOB TO VARIABLE:C533([Activity Log:59]Data:10; picStuff; $vlOffset)
			$SQLUpdate_txt:=$SQLUpdate_txt+":picStuff"
			If (Picture size:C356(picStuff)=0)
				GET PICTURE FROM LIBRARY:C565(30288; picStuff)
			End if 
		: ([Activity Log:59]Data Type:11=Is date:K8:7)  //Date
			BLOB TO VARIABLE:C533([Activity Log:59]Data:10; dStuff; $vlOffset)
			$SQLUpdate_txt:=$SQLUpdate_txt+":dStuff"
		: ([Activity Log:59]Data Type:11=Is boolean:K8:9)  //Boolean
			BLOB TO VARIABLE:C533([Activity Log:59]Data:10; bStuff; $vlOffset)
			$SQLUpdate_txt:=$SQLUpdate_txt+":bStuff"
			
		: ([Activity Log:59]Data Type:11=Is integer:K8:5) | ([Activity Log:59]Data Type:11=Is longint:K8:6)  //Integer
			
			BLOB TO VARIABLE:C533([Activity Log:59]Data:10; lStuff; $vlOffset)
			VARIABLE TO BLOB:C532(lStuff; OldFieldID)
			$SQLUpdate_txt:=$SQLUpdate_txt+":lStuff"
			$vLookupValue_S:=String:C10(lStuff)
		: ([Activity Log:59]Data Type:11=Is time:K8:8)  //Time
			BLOB TO VARIABLE:C533([Activity Log:59]Data:10; timeStuff; $vlOffset)
			$SQLUpdate_txt:=$SQLUpdate_txt+":timeStuff"
			
		: ([Activity Log:59]Data Type:11=Is BLOB:K8:12)  //Blob
			xStuff:=[Activity Log:59]Data:10
			$SQLUpdate_txt:=$SQLUpdate_txt+":xStuff"
	End case 
	ut_Message("Field=["+Table name:C256([Activity Log:59]File Number:7)+"]"+[Activity Log:59]ActField Name:20+<>sCR)
	If ([Activity Log:59]Activity Type:3="LNK")
		C_LONGINT:C283($Tablenumber_l)
		
		BLOB TO VARIABLE:C533([Activity Log:59]Data:10; $Tablenumber_l; $vlOffset)
		If (($Tablenumber_l=0) | (OK=0))
			$Tablenumber_l:=[Activity Log:59]File Number:7
			Case of 
				: ([Activity Log:59]ActField Name:20="NBISInspID")
					$Tablenumber_l:=Table:C252(->[Inspections:27])
				: ([Activity Log:59]ActField Name:20="BMSInspID")
					$Tablenumber_l:=Table:C252(->[BMS Inspections:44])
			End case 
		End if 
		$vLookupValue_S:=aLookUpDest($Tablenumber_l; $vLookupValue_S; <>Destination)
		If ($vLookupValue_S="")
		Else 
			Case of 
				: ([Activity Log:59]Data Type:11=Is alpha field:K8:1)  //Alpha
					aStuff:=$vLookupValue_S
					
				: ([Activity Log:59]Data Type:11=Is longint:K8:6) | ([Activity Log:59]Data Type:11=Is integer:K8:5)  //Integer  `longint
					lStuff:=Num:C11($vLookupValue_S)
			End case 
		End if 
		Case of 
			: ([Activity Log:59]Data Type:11=Is alpha field:K8:1)  //Alpha
				VARIABLE TO BLOB:C532(aStuff; NewFieldID)
			: ([Activity Log:59]Data Type:11=Is longint:K8:6) | ([Activity Log:59]Data Type:11=Is integer:K8:5)
				VARIABLE TO BLOB:C532(lStuff; NewFieldID)
		End case 
		VARIABLE TO BLOB:C532($Tablenumber_l; NewFieldID; *)
		
	End if 
	
	
	
	$SQLUpdate_txt:=$SQLUpdate_txt+$SQLWhereQuery_txt+";"
	ut_SQLExecuteNoReturn($SQLUpdate_txt)
	
	If (ut_fTestForSQLor4DError)
		
		ut_SQLUpdateServerActLog
	Else 
		ut_SQLWriteErrorsToLog("Act Log error in update "+Current method name:C684+" -ID "+String:C10([Activity Log:59]RefID:28)+<>sCR)
		vbOnScreenMessage:=False:C215
		ut_Message($SQLUpdate_txt)
	End if 
Else 
	If (Not:C34(RecordLocked_b))
	Else 
		ut_SQLWriteCommonError(Current method name:C684; $Numrec_l; $SQLSelectQuery_txt)
	End if 
End if 
vbOnScreenMessage:=$OriginalonScreen_b

SET BLOB SIZE:C606(NewFieldID; 0)
SET BLOB SIZE:C606(OldFieldID; 0)
// End Method: ut_SQLTellServerField