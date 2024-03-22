//%attributes = {"invisible":true}
//GP BMS_MissInsp
//Copyright © 1998, Thomas D. Nee, All Rights Reserved.

//Find bridges without BMS Inspections.

ARRAY TEXT:C222($aInspResp; 0)  //Command Replaced was o_ARRAY string length was 5
C_TEXT:C284($text)
C_LONGINT:C283($i; $NumNBIS; $NumWithout; $Inspections)

$text:="Create a report of missing Pontis inspections?"
CONFIRM:C162($text)

//TRACE
C_TIME:C306($dPontisRpt)
If (OK=1)
	$dPontisRpt:=Create document:C266("")
	If (OK=1)
		vdUpdateRpt:=$dPontisRpt
		C_DATE:C307($Earliest)
		//    $InspResp:="DIST1"
		$Earliest:=!1995-10-01!
		
		//    SEARCH([Bridge MHD NBIS];[Bridge MHD NBIS]InspResp=$InspResp;*)
		QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]FHWARecord:174=True:C214)
		$NumNBIS:=Records in selection:C76([Bridge MHD NBIS:1])
		CREATE SET:C116([Bridge MHD NBIS:1]; "All NBIS Bridges")
		
		RELATE MANY SELECTION:C340([BMS Inspections:44]BIN:2)
		QUERY SELECTION:C341([BMS Inspections:44]; [BMS Inspections:44]Insp Date:4>=$Earliest)
		RELATE ONE SELECTION:C349([BMS Inspections:44]; [Bridge MHD NBIS:1])
		CREATE SET:C116([Bridge MHD NBIS:1]; "w/Recent Insp")
		DIFFERENCE:C122("All NBIS Bridges"; "w/Recent Insp"; "No Recent Insp")
		USE SET:C118("No Recent Insp")
		$NumWithout:=Records in selection:C76([Bridge MHD NBIS:1])
		
		ORDER BY:C49([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]InspResp:173; [Bridge MHD NBIS:1]BDEPT:1; [Bridge MHD NBIS:1]BIN:3)
		If (True:C214)
			//      If (false)
			//Activate this block for creating a file listing all bridges without inspections.
			For ($i; 1; $NumWithout)
				$text:=[Bridge MHD NBIS:1]InspResp:173+<>sTAB+[Bridge MHD NBIS:1]BDEPT:1+<>sTAB+[Bridge MHD NBIS:1]BIN:3+<>sTAB+[Bridge MHD NBIS:1]Item8:206+<>sTAB
				$text:=$text+[Bridge MHD NBIS:1]Item7:65+<>sTAB+[Bridge MHD NBIS:1]Item6A:63+<>sTAB
				RELATE MANY:C262([Bridge MHD NBIS:1]BIN:3)
				$Inspections:=Records in selection:C76([BMS Inspections:44])
				If ($Inspections>1)
					ORDER BY:C49([BMS Inspections:44]; [BMS Inspections:44]Insp Date:4; <)
				End if 
				If ($Inspections=0)
					$text:=$text+"***** No Inspections in Database *****"+<>sCR
				Else 
					$text:=$text+String:C10([BMS Inspections:44]Insp Date:4)+<>sCR
				End if 
				SEND PACKET:C103($dPontisRpt; $text)
				NEXT RECORD:C51([Bridge MHD NBIS:1])
			End for 
			$text:=(2*<>sCR)
			SEND PACKET:C103($dPontisRpt; $text)
		End if 
		
		//This block creates a summary for each inspecting entity.    
		FIRST RECORD:C50([Bridge MHD NBIS:1])
		DISTINCT VALUES:C339([Bridge MHD NBIS:1]InspResp:173; $aInspResp)
		$text:="InspResp"+<>sTAB+"Total"+<>sTAB+"No Insp"+<>sTAB+"% No Insp"+<>sCR
		$text:=$text+"All NBIS"+<>sTAB+String:C10($NumNBIS)+<>sTAB+String:C10($NumWithout)
		$text:=$text+<>sTAB+String:C10(Round:C94(100*$NumWithout/$NumNBIS; 1))+<>sCR
		SEND PACKET:C103($dPontisRpt; $text)
		For ($i; 1; Size of array:C274($aInspResp))
			USE SET:C118("All NBIS Bridges")
			QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]InspResp:173=$aInspResp{$i})
			$NumNBIS:=Records in selection:C76([Bridge MHD NBIS:1])
			USE SET:C118("No Recent Insp")
			QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]InspResp:173=$aInspResp{$i})
			$NumWithout:=Records in selection:C76([Bridge MHD NBIS:1])
			$text:=$aInspResp{$i}+<>sTAB+String:C10($NumNBIS)+<>sTAB+String:C10($NumWithout)
			$text:=$text+<>sTAB+String:C10(Round:C94(100*$NumWithout/$NumNBIS; 1))+<>sCR
			SEND PACKET:C103($dPontisRpt; $text)
		End for 
		
		CLOSE DOCUMENT:C267($dPontisRpt)
	End if 
End if 