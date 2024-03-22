//%attributes = {"invisible":true}
If (Current user:C182="Designer")
	READ ONLY:C145(*)
	
	QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Insp Date:4>!2004-01-01!)
	C_LONGINT:C283($vlchkrecs; $i)
	$vlchkrecs:=Records in selection:C76([BMS Inspections:44])
	C_DATE:C307($vInsp_Date; $vInspMin_Date; $vInspMax_Date)
	C_TEXT:C284($vsBIN)  // Command Replaced was o_C_STRING length was 4
	C_TIME:C306($docrpt)
	$docrpt:=Create document:C266(""; "TEXT")
	
	SHORT_MESSAGE("Starting.."+String:C10($vlchkrecs))
	
	FIRST RECORD:C50([BMS Inspections:44])
	For ($i; 1; $vlchkrecs)
		MESSAGE:C88(String:C10($i)+" of  "+String:C10($vlchkrecs)+<>sCR)
		
		$vInspMin_Date:=[BMS Inspections:44]Insp Date:4-7
		$vInspMax_Date:=[BMS Inspections:44]Insp Date:4+7
		$vsBIN:=[BMS Inspections:44]BIN:2
		QUERY:C277([Inspections:27]; [Inspections:27]BIN:1=$vsBIN)
		QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Date:78>=$vInspMin_Date; *)
		QUERY SELECTION:C341([Inspections:27];  & ; [Inspections:27]Insp Date:78<=$vInspMax_Date)
		QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6="RT@"; *)
		QUERY SELECTION:C341([Inspections:27];  | ; [Inspections:27]Insp Type:6="CUL")
		If (Records in selection:C76([Inspections:27])=0)
			SEND PACKET:C103($docrpt; [BMS Inspections:44]BIN:2+<>sCR)
		End if 
		
		NEXT RECORD:C51([BMS Inspections:44])
	End for 
	CLOSE DOCUMENT:C267($docrpt)
	CLOSE WINDOW:C154
	
End if 