//%attributes = {"invisible":true}
SET CURSOR:C469(128)
If (False:C215)
	QUERY:C277([BMS Inspections:44]; [Bridge MHD NBIS:1]FHWARecord:174=True:C214)
Else 
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]FHWARecord:174=True:C214)
	RELATE MANY SELECTION:C340([BMS Inspections:44]BIN:2)
End if 

ORDER BY:C49([BMS Inspections:44]; [BMS Inspections:44]BIN:2; >; [BMS Inspections:44]Insp Date:4; <)
ARRAY LONGINT:C221(alINSPIDS; 0)
ARRAY DATE:C224(aDINSPDates; 0)
ARRAY TEXT:C222(asBINS; 0)  //Command Replaced was o_ARRAY string length was 3
SELECTION TO ARRAY:C260([BMS Inspections:44]BIN:2; asBINS; [BMS Inspections:44]Inspection ID:1; alINSPIDS; [BMS Inspections:44]Insp Date:4; aDINSPDates)
C_LONGINT:C283($i; $vlNumInsps)
$vlNumInsps:=Records in selection:C76([BMS Inspections:44])
ARRAY LONGINT:C221(aLatestIDs; 1)
aLatestIDs{1}:=alINSPIDS{1}
C_TEXT:C284($vsBIN)  // Command Replaced was o_C_STRING length was 3
$vsBIN:=asBINS{1}
For ($i; 2; $vlNumInsps)
	If (asBINS{$i}#$vsBIN)
		$vsBIN:=asBINS{$i}
		INSERT IN ARRAY:C227(aLatestIDs; (Size of array:C274(aLatestIDs)+1))
		aLatestIDs{Size of array:C274(aLatestIDs)}:=alINSPIDS{$i}
	End if 
	
End for 

QUERY WITH ARRAY:C644([BMS Inspections:44]Inspection ID:1; aLatestIDs)
RELATE MANY SELECTION:C340([Cond Units:45]Inspection ID:2)
ALERT:C41("Search for element type")
QUERY SELECTION:C341([Cond Units:45])
ALERT:C41("Search for element States")
QUERY SELECTION:C341([Cond Units:45])
CREATE SET:C116([Cond Units:45]; "CondUnitsBad")
RELATE ONE SELECTION:C349([Cond Units:45]; [BMS Inspections:44])
RELATE ONE SELECTION:C349([BMS Inspections:44]; [Bridge MHD NBIS:1])
//clear SD Bridges
QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]StructDef:103=False:C215)
RELATE MANY SELECTION:C340([BMS Inspections:44]BIN:2)
RELATE MANY SELECTION:C340([Cond Units:45]Inspection ID:2)
CREATE SET:C116([Cond Units:45]; "NonSDCondUnits")
INTERSECTION:C121("NonSDCondUnits"; "CondUnitsBad"; "ResultCondUnits")
USE SET:C118("ResultCondUnits")
CLEAR SET:C117("CondUnitsBad")
CLEAR SET:C117("NonSDCondUnits")
CLEAR SET:C117("ResultCondUnits")
ALERT:C41("Found "+String:C10(Records in selection:C76([Cond Units:45]))+" Matching Condition Units.")
QR REPORT:C197([Cond Units:45]; Char:C90(1))
SET CURSOR:C469(0)