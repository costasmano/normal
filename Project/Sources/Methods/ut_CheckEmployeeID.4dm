//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/27/05, 13:45:40
	// ----------------------------------------------------
	// Method: ut_CheckEmployeeID
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM13
	
End if 
C_TEXT:C284($ID_S)  // Command Replaced was o_C_STRING length was 10
C_LONGINT:C283($ID_I)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($NumInsps; $NumInspMemb; $NumBMSInsps; $NumBMSMem)

$ID_S:=Request:C163("Enter Employee ID num")
$ID_I:=Num:C11($ID_S)
SET QUERY DESTINATION:C396(Into variable:K19:4; $NumInsps)
QUERY:C277([Inspections:27]; [Inspections:27]DBrInspEngr:3=$ID_I; *)
QUERY:C277([Inspections:27];  | ; [Inspections:27]TeamLeader:4=$ID_I)
SET QUERY DESTINATION:C396(Into variable:K19:4; $NumInspMemb)
QUERY:C277([Field Trip:43]; [Field Trip:43]Person ID:2=$ID_I)
SET QUERY DESTINATION:C396(Into variable:K19:4; $NumBMSInsps)
QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]DBrInspEngr:5=$ID_I; *)
QUERY:C277([BMS Inspections:44];  | ; [BMS Inspections:44]TeamLeader:6=$ID_I)
SET QUERY DESTINATION:C396(Into variable:K19:4; $NumBMSMem)
QUERY:C277([BMS Field Trip:56]; [BMS Field Trip:56]Person ID:2=$ID_I)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
C_TEXT:C284($msg)
$msg:="Report for ID "+String:C10($ID_I)+" - NUM NBI INSP:"+String:C10($NumInsps)
$msg:=$msg+" - Num NBI team:"+String:C10($NumInspMemb)
$msg:=$msg+" - Num BMS INSP:"+String:C10($NumBMSInsps)
$msg:=$msg+" - Num BMS team:"+String:C10($NumBMSMem)
$msg:=$msg+<>sCR+" - Total:"+String:C10($NumInsps+$NumInspMemb+$NumBMSInsps+$NumBMSMem)

ALERT:C41($msg)