//%attributes = {"invisible":true}
If (False:C215)
	Mods_2011_06  // CJ Miller`06/14/11, 10:47:28      ` Type all local variables for v11
End if 
If (Current user:C182="Designer")
	READ ONLY:C145(*)
	
	ALL RECORDS:C47([Inspections:27])
	C_LONGINT:C283($vlNumInsps; $i; $0)
	$vlNumInsps:=Records in selection:C76([Inspections:27])
	FIRST RECORD:C50([Inspections:27])
	C_TEXT:C284($vdatespan_s)
	C_LONGINT:C283($vdatespan_l)
	$vdatespan_s:=Request:C163("Day span?")
	$vdatespan_l:=Num:C11($vdatespan_s)
	C_TIME:C306($docrpt)
	$docrpt:=Create document:C266(""; "TEXT")
	C_LONGINT:C283($errCount)
	$errCount:=0
	C_DATE:C307($vInsp_Date; $vInspMin_Date; $vInspMax_Date)
	C_TEXT:C284($vsBIN)  // Command Replaced was o_C_STRING length was 3
	SHORT_MESSAGE("Starting.."+String:C10($vlNumInsps))
	For ($i; 1; $vlNumInsps)
		MESSAGE:C88(String:C10($i)+" of  "+String:C10($vlNumInsps)+<>sCR)
		If (([Inspections:27]Insp Type:6="RT@") | ([Inspections:27]Insp Type:6="CUL"))
			$vInspMin_Date:=[Inspections:27]Insp Date:78-$vdatespan_l
			$vInspMax_Date:=[Inspections:27]Insp Date:78+$vdatespan_l
			$vsBIN:=[Inspections:27]BIN:1
			QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]BIN:2=$vsBIN)
			
			QUERY SELECTION:C341([BMS Inspections:44]; [BMS Inspections:44]Insp Date:4>=$vInspMin_Date; *)
			QUERY SELECTION:C341([BMS Inspections:44];  & ; [BMS Inspections:44]Insp Date:4<=$vInspMax_Date)
			If (Records in selection:C76([BMS Inspections:44])>1)
				SEND PACKET:C103($docrpt; [Inspections:27]BIN:1+<>sCR)
				$errcount:=$errCount+1
			End if 
			
		End if 
		NEXT RECORD:C51([Inspections:27])
		
	End for 
	CLOSE DOCUMENT:C267($docrpt)
	CLOSE WINDOW:C154
	
	$docrpt:=Create document:C266(""; "TEXT")
	C_LONGINT:C283($errCount)
	$errCount:=0
	//ALL RECORDS([BMS Inspections])
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"REM"; *)
	QUERY:C277([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"DES")
	RELATE MANY SELECTION:C340([BMS Inspections:44]BIN:2)
	QUERY SELECTION:C341([BMS Inspections:44]; [BMS Inspections:44]Insp Date:4>!1997-12-25!)
	C_LONGINT:C283($vDuplicatePontis)
	$vlNumInsps:=Records in selection:C76([BMS Inspections:44])
	SHORT_MESSAGE("Starting again.."+String:C10($vlNumInsps))
	FIRST RECORD:C50([BMS Inspections:44])
	For ($i; 1; $vlNumInsps)
		MESSAGE:C88(String:C10($i)+" of  "+String:C10($vlNumInsps)+<>sCR)
		//If (([Inspections]Insp Type="RT@") | ([Inspections]Insp Type="CUL"))    
		$vInspMin_Date:=[BMS Inspections:44]Insp Date:4-$vdatespan_l
		$vInspMax_Date:=[BMS Inspections:44]Insp Date:4+$vdatespan_l
		$vsBIN:=[BMS Inspections:44]BIN:2
		SET QUERY DESTINATION:C396(Into variable:K19:4; $vDuplicatePontis)
		QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]BIN:2=$vsBIN; *)
		QUERY:C277([BMS Inspections:44];  & ; [BMS Inspections:44]Insp Date:4>=$vInspMin_Date; *)
		QUERY:C277([BMS Inspections:44];  & ; [BMS Inspections:44]Insp Date:4<=$vInspMax_Date)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If ($vDuplicatePontis>1)
			SEND PACKET:C103($docrpt; [BMS Inspections:44]BIN:2+<>sCR)
			$errcount:=$errCount+1
		End if 
		
		//End if 
		NEXT RECORD:C51([BMS Inspections:44])
		
	End for 
	CLOSE DOCUMENT:C267($docrpt)
	CLOSE WINDOW:C154
	
End if 