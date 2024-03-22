//%attributes = {"invisible":true}


// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 06/18/10, 11:44:16
// ----------------------------------------------------
// Method: ut_SQLSelectForLoad
// Description
// 
//
// Parameters
// ----------------------------------------------------
//$Numrec_l:=ut_SQLSelectForLoad ($SQLSelectQuery_txt;[Activity_Log]Local Type)

//$0 size of array returned
//$1 the select statement
//$2 the type
// Modified by: Charles Miller (6/18/10)
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:14:35) 
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (9/3/10 15:39:54)
	//Ugrade to v11
	//Modified by: Charles Miller (4/28/11 17:00:51)
	//Ugrade to v11
	//Modified by: Charles Miller (5/10/11 16:25:29)
	Mods_2019_06  //Add remote key for table to alert if record locked
	//Modified by: Chuck Miller (6/6/19 16:47:23)
	Mods_2019_08  //Code to get exact locking information from remote server. It is commented out
	//Modified by: Chuck Miller (8/20/19 13:26:56)
	
End if 
ARRAY TEXT:C222($Returnvalues_atxt; 0)
ARRAY LONGINT:C221($Returnvalues_al; 0)

C_LONGINT:C283($0; $2; $Type_l; $ReturnValue_l)
$Type_l:=$2
C_TEXT:C284($1; $SQL_Select_txt)
$SQL_Select_txt:=$1
SQLError_b:=False:C215
4DError_b:=False:C215
ARRAY TEXT:C222($Returnvalues_atxt; 0)
ARRAY LONGINT:C221($Returnvalues_al; 0)
C_LONGINT:C283($NumberOfTrys_l)
C_BOOLEAN:C305($Complete_b)
ON ERR CALL:C155("SQL_ERROR")
$Complete_b:=False:C215
C_LONGINT:C283($pos_L)
C_TEXT:C284($RemoteKey_txt)
C_TEXT:C284($Type_txt)
$Type_txt:=""
Repeat 
	If ($Type_l=0)
		$RemoteKey_txt:=String:C10(RefID_l)
		ARRAY TEXT:C222($Returnvalues_atxt; 0)
		SQL EXECUTE:C820($SQL_Select_txt; $Returnvalues_atxt)
		$Type_txt:="Number"
	Else 
		$RemoteKey_txt:=RefID_s
		ARRAY LONGINT:C221($Returnvalues_al; 0)
		SQL EXECUTE:C820($SQL_Select_txt; $Returnvalues_al)
	End if 
	
	If (SQLError_b)
		If (SQLErrorNumbers_al{1}=1066)
			SQLError_b:=False:C215
			$NumberOfTrys_l:=$NumberOfTrys_l+1
			If ($NumberOfTrys_l=1) & (Not:C34(InWHKRUpdate_b))
				C_LONGINT:C283($TableNumber_L; $FieldNumber_L)
				C_BLOB:C604($Return_blb)
				C_LONGINT:C283($Offset_L; $Key_L)
				C_TEXT:C284($KeyValue_txt)
				C_BLOB:C604(Send_Blb; Receive_Blb)
				$KeyValue_txt:=$RemoteKey_txt
				$TableNumber_L:=[Activity Log:59]FileID Local:24
				$FieldNumber_L:=[Activity Log:59]FieldID Local:25
				VARIABLE TO BLOB:C532($TableNumber_L; Send_Blb; *)
				VARIABLE TO BLOB:C532($FieldNumber_L; Send_Blb; *)
				VARIABLE TO BLOB:C532($Type_txt; Send_Blb; *)
				VARIABLE TO BLOB:C532($KeyValue_txt; Send_Blb; *)
				
				SQLQuery_txt:="SELECT {fn FN_ReturnLockedRecords(<<Send_Blb>>) AS BLOB} from preferences INTO :Receive_Blb"
				
				
				Begin SQL
					EXECUTE IMMEDIATE :SQLQuery_txt;
				End SQL
				C_TEXT:C284($ProcessName_txt; $User_txt; $Machine_txt)
				
				$Offset_L:=0
				BLOB TO VARIABLE:C533(Receive_Blb; $User_txt; $Offset_L)
				BLOB TO VARIABLE:C533(Receive_Blb; $Machine_txt; $Offset_L)
				BLOB TO VARIABLE:C533(Receive_Blb; $ProcessName_txt; $Offset_L)
			End if 
			If ($NumberOfTrys_l>5)
				//If (Current user="designer")  // This will only work when we have an activity log record loaded
				
				CONFIRM:C162("Record in table "+Table name:C256($TableNumber_L)+" is locked by "+$User_txt+" on machine "+$Machine_txt+" in process "+$ProcessName_txt; "Try Again"; "Cancel Transfer")
				If (OK=1)
					$NumberOfTrys_l:=0
				Else 
					RecordLocked_b:=False:C215
					$Complete_b:=True:C214
					AbortDueToLockedRecord_b:=True:C214
				End if 
				
			Else 
				C_TEXT:C284($Message_txt)
				$Message_txt:="Record in table "+Table name:C256($TableNumber_L)+" is locked by "+$User_txt+" on machine "+$Machine_txt+" in process "+$ProcessName_txt+"Remote key is"+$RemoteKey_txt+" try number "+String:C10($NumberOfTrys_l)+Char:C90(Carriage return:K15:38)
				ut_Message($Message_txt)
				IDLE:C311
				DELAY PROCESS:C323(Current process:C322; 150)
			End if 
			
		End if 
	Else 
		RecordLocked_b:=True:C214
		$Complete_b:=True:C214
	End if 
Until ($Complete_b)
If (RecordLocked_b)
	While (Not:C34(SQL End selection:C821)) & (Not:C34(SQLError_b))
		SQL LOAD RECORD:C822(SQL all records:K49:10)
	End while 
	SQL CANCEL LOAD:C824
End if 
ON ERR CALL:C155("4D_Errors")
C_LONGINT:C283($Numrec_l)
$Numrec_l:=Size of array:C274($Returnvalues_atxt)+Size of array:C274($Returnvalues_al)
C_BOOLEAN:C305($OriginalonScreen_b)
$OriginalonScreen_b:=vbOnScreenMessage
C_TEXT:C284($TableName_txt; $Error_txt)
If (Not:C34(InWHKRUpdate_b))
	Case of 
		: (Not:C34(RecordLocked_b))
			vbOnScreenMessage:=False:C215
			
			ut_SQLWriteErrorsToLog($SQL_Select_txt+<>CR+" record locked "+Char:C90(Carriage return:K15:38))
			vbOnScreenMessage:=$OriginalonScreen_b
			ut_Message("Remote record for table locked "+Table name:C256([Activity Log:59]FileID Local:24)+" Ref ID "+REFID_s+" Parent ID "+ParentID_s+Char:C90(Carriage return:K15:38))
			If (SQLError_b)
				ut_SQLWriteErrorsToLog("Error in Load "+Current method name:C684+Char:C90(Carriage return:K15:38)+$SQL_Select_txt+Char:C90(Carriage return:K15:38))
			End if 
			SQLError_b:=False:C215
		: (SQLError_b) | (4DError_b)
			vbOnScreenMessage:=False:C215
			ut_SQLWriteErrorsToLog("Error in select "+Current method name:C684+Char:C90(Carriage return:K15:38)+$SQL_Select_txt+Char:C90(Carriage return:K15:38))
			vbOnScreenMessage:=$OriginalonScreen_b
			ut_Message("Error in select for table "+Table name:C256([Activity Log:59]FileID Local:24)+" Ref ID "+REFID_s+" Parent ID "+ParentID_s+Char:C90(Carriage return:K15:38))
		Else 
			//ut_Message ("Select for table"+Table name([Activity_Log]File Number)+" "+◊sCR)
	End case 
Else 
	If (WKHR_SRCH_AddendNo_L=0)
		$TableName_txt:="Assignment"
	Else 
		$TableName_txt:="Addendum"
	End if 
	Case of 
		: (Not:C34(RecordLocked_b))
			vbOnScreenMessage:=False:C215
			SQLError_b:=False:C215
			ALERT:C41("The  "+$TableName_txt+" record is locked. You will have to try again at a later time")
		: (SQLError_b) | (4DError_b)
			$Error_txt:="Error Number, Internal Code, Description"+Char:C90(Carriage return:K15:38)
			C_LONGINT:C283($Loop_l)
			For ($Loop_l; 1; Size of array:C274(SQLErrorNumbers_al))
				$Error_txt:=$Error_txt+String:C10(SQLErrorNumbers_al{$Loop_l})+","+SQL_InternalCodes_atxt{$Loop_l}+","+SQL_InternalDescriptions_atxt{$Loop_l}+Char:C90(Carriage return:K15:38)
			End for 
			ALERT:C41($Error_txt)
			
	End case 
End if 


$ReturnValue_l:=Size of array:C274($Returnvalues_atxt)+Size of array:C274($Returnvalues_al)
ARRAY TEXT:C222($Returnvalues_atxt; 0)
ARRAY LONGINT:C221($Returnvalues_al; 0)
$0:=$ReturnValue_l
