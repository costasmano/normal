//%attributes = {"invisible":true}
//GP BMS_ExpPontis
//Copyright © 1998-99, Thomas D. Nee, All Rights Reserved.

//Create a text file in Pontis Data Interchange (PDI) format.

C_TEXT:C284($text)
C_LONGINT:C283($i; $recs; $j; $CUs)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($sBreaker)  // Command Replaced was o_C_STRING length was 41

$text:="Do you want to create a Pontis PDI file?"
CONFIRM:C162($text)

//TRACE
C_TIME:C306($dPontisExp)
If (OK=1)
	$dPontisExp:=Create document:C266("")
	If (OK=1)
		vdUpdateRpt:=$dPontisExp
		$sBreaker:=(40*"#")+<>sCR
		
		$text:=$sBreaker
		$text:=$text+"# Start of Pontis Import File"+<>sCR
		$text:=$text+$sBreaker
		$text:=$text+"BEGIN DOCUMENTATION"+(2*<>sCR)
		$text:=$text+"Pontis BMS Inspections"+<>sCR
		$text:=$text+"Exported from MHD BMS"+<>sCR
		$text:=$text+String:C10(Current date:C33(*))+" "+String:C10(Current time:C178(*))+(2*<>sCR)
		$text:=$text+"END DOCUMENTATION"+(2*<>sCR)
		SEND PACKET:C103($dPontisExp; $text)
		
		$text:=$sBreaker
		$text:=$text+"# Operation = Import"+<>sCR
		$text:=$text+$sBreaker
		$text:=$text+"OPERATION IMPORT"+(2*<>sCR)
		$text:=$text+$sBreaker
		$text:=$text+"# Definitions Section"+<>sCR
		$text:=$text+$sBreaker
		$text:=$text+"BEGIN DEFINITIONS"+<>sCR
		$text:=$text+<>sTAB+"STAMP TODAY + "+<>sQU+" "+<>sQU+" + NOW"+<>sCR
		//$text:=$text+◊sTAB+"VARIABLE     $VAR_UNIQUE_KEY UNIQUEKEY(inspevnt.inspkey)"+◊s
		$text:=$text+<>sTAB+"VARIABLE     $VAR_USER CONSTANT(Pontis User)"+<>sCR
		$text:=$text+<>sTAB+"TABLE     inspevnt MODE(AddOnly)"+<>sCR
		$text:=$text+(2*<>sTAB)+"COLUMN     inspkey"+<>sCR
		$text:=$text+(2*<>sTAB)+"COLUMN     brkey"+<>sCR
		$text:=$text+(2*<>sTAB)+"COLUMN     inspdate"+<>sCR
		$text:=$text+(2*<>sTAB)+"COLUMN     elinsdone OMIT CONSTANT(1)"+<>sCR
		$text:=$text+(2*<>sTAB)+"COLUMN     elinsdate OMIT COMPUTE(inspdate)"+<>sCR
		$text:=$text+(2*<>sTAB)+"COLUMN     notes APPEND COMPUTE("+<>sQU+" "+<>sQU+" + STAMP + "+<>sQU+" "+<>sQU+" + notes)"+<>sCR
		$text:=$text+<>sTAB+"TABLE     condunit MODE(AddUpdate)"+<>sCR
		$text:=$text+(2*<>sTAB)+"COLUMN     brkey"+<>sCR
		//In Pontis the main span group is 0; the approach span is 1.
		//We are currently using only one span group, so set it to 0.
		$text:=$text+(2*<>sTAB)+"COLUMN     spankey OMIT CONSTANT(0)"+<>sCR
		$text:=$text+(2*<>sTAB)+"COLUMN     elemkey"+<>sCR
		$text:=$text+(2*<>sTAB)+"COLUMN     envkey"+<>sCR
		$text:=$text+(2*<>sTAB)+"COLUMN     quantity"+<>sCR
		$text:=$text+<>sTAB+"TABLE     eleminsp MODE(AddOnly)"+<>sCR
		$text:=$text+(2*<>sTAB)+"COLUMN     brkey"+<>sCR
		$text:=$text+(2*<>sTAB)+"COLUMN     spankey OMIT CONSTANT(0)"+<>sCR
		$text:=$text+(2*<>sTAB)+"COLUMN     elemkey"+<>sCR
		$text:=$text+(2*<>sTAB)+"COLUMN     envkey"+<>sCR
		$text:=$text+(2*<>sTAB)+"COLUMN     inspkey"+<>sCR
		$text:=$text+(2*<>sTAB)+"COLUMN     elinspdate"+<>sCR
		//    $text:=$text+(2*◊sTAB)+"COLUMN     pctstate1"+◊sCR
		$text:=$text+(2*<>sTAB)+"COLUMN     qtystate1"+<>sCR
		//    $text:=$text+(2*◊sTAB)+"COLUMN     pctstate2"+◊sCR
		$text:=$text+(2*<>sTAB)+"COLUMN     qtystate2"+<>sCR
		//    $text:=$text+(2*◊sTAB)+"COLUMN     pctstate3"+◊sCR
		$text:=$text+(2*<>sTAB)+"COLUMN     qtystate3"+<>sCR
		//    $text:=$text+(2*◊sTAB)+"COLUMN     pctstate4"+◊sCR
		$text:=$text+(2*<>sTAB)+"COLUMN     qtystate4"+<>sCR
		//    $text:=$text+(2*◊sTAB)+"COLUMN     pctstate5"+◊sCR
		$text:=$text+(2*<>sTAB)+"COLUMN     qtystate5"+<>sCR
		$text:=$text+"END DEFINITIONS"+(2*<>sCR)
		$text:=$text+$sBreaker
		$text:=$text+"# Data Section"+<>sCR
		$text:=$text+$sBreaker
		$text:=$text+"BEGIN DATA"+(2*<>sCR)
		SEND PACKET:C103($dPontisExp; $text)
		
		FIRST RECORD:C50([BMS Inspections:44])
		$recs:=Records in selection:C76([BMS Inspections:44])
		For ($i; 1; $recs)
			//      COPY NAMED SELECTION([BMS Inspections];"Inspection Selection")
			$text:="###  Inspection "+String:C10($i; "0000")+<>sCR
			$text:=$text+"BEGIN TRANSACTION"+<>sCR
			$text:=$text+<>sTAB+"TABLE inspevnt"+<>sCR
			//inspevnt fields.
			$text:=$text+(2*<>sTAB)+<>sQU+String:C10([BMS Inspections:44]Inspection ID:1; "000000")+<>sQU+","+<>sQU+[BMS Inspections:44]BIN:2+<>sQU+","
			$text:=$text+<>sQU+String:C10(Year of:C25([BMS Inspections:44]Insp Date:4))+String:C10(Month of:C24([BMS Inspections:44]Insp Date:4); "00")+String:C10(Day of:C23([BMS Inspections:44]Insp Date:4); "00")+<>sQU
			$text:=$text+","+<>sQU+<>sQU+<>sCR  //Notes - We have no notes for the entire inspection
			RELATE MANY:C262([BMS Inspections:44]Inspection ID:1)
			ORDER BY:C49([Cond Units:45]; [Cond Units:45]Cond Unit ID:1)
			$CUs:=Records in selection:C76([Cond Units:45])
			$text:=$text+<>sTAB+"TABLE condunit"+<>sCR
			For ($j; 1; $CUs)
				RELATE ONE:C42([Cond Units:45]Element ID:3)
				//condunit fields.
				$text:=$text+(2*<>sTAB)+<>sQU+[BMS Inspections:44]BIN:2+<>sQU+","
				$text:=$text+<>sQU+String:C10([BMS Elements:47]Element No:2)+<>sQU+","+<>sQU+String:C10([Cond Units:45]Environment:4)+<>sQU+","+<>sQU+String:C10([Cond Units:45]Total Quantity:5)+<>sQU+<>sCR
				NEXT RECORD:C51([Cond Units:45])
			End for 
			
			FIRST RECORD:C50([Cond Units:45])
			$text:=$text+<>sTAB+"TABLE eleminsp"+<>sCR
			For ($j; 1; $CUs)
				RELATE ONE:C42([Cond Units:45]Element ID:3)
				//eleminsp fields.
				$text:=$text+(2*<>sTAB)+<>sQU+[BMS Inspections:44]BIN:2+<>sQU+","
				$text:=$text+<>sQU+String:C10([BMS Elements:47]Element No:2)+<>sQU+","+<>sQU+String:C10([Cond Units:45]Environment:4)+<>sQU+","
				$text:=$text+<>sQU+String:C10([Cond Units:45]Inspection ID:2; "000000")+<>sQU+","  //+$VAR_UNIQUE_KEY
				$text:=$text+<>sQU+String:C10(Year of:C25([BMS Inspections:44]Insp Date:4))+String:C10(Month of:C24([BMS Inspections:44]Insp Date:4); "00")+String:C10(Day of:C23([BMS Inspections:44]Insp Date:4); "00")+<>sQU+","
				//Elements have between 3 and 5 condition states.
				//A negative value indicates the condition state does not exist; display as null.
				$text:=$text+<>sQU+String:C10([Cond Units:45]CondState1:10; "#########.######;;0")+<>sQU+","+<>sQU+String:C10([Cond Units:45]CondState2:11; "#########.######;;0")+<>sQU+","
				$text:=$text+<>sQU+String:C10([Cond Units:45]CondState3:12; "#########.######;;0")+<>sQU+","+<>sQU+String:C10([Cond Units:45]CondState4:13; "#########.######;;0")+<>sQU+","
				$text:=$text+<>sQU+String:C10([Cond Units:45]CondState5:14; "#########.######;;0")+<>sQU+<>sCR
				NEXT RECORD:C51([Cond Units:45])
			End for 
			$text:=$text+"END TRANSACTION"+(2*<>sCR)
			SEND PACKET:C103($dPontisExp; $text)
			
			//      USE NAMED SELECTION("Inspection Selection")
			NEXT RECORD:C51([BMS Inspections:44])
		End for 
		//    CLEAR NAMED SELECTION("Inspection Selection")
		
		$text:=<>sCR+"END DATA"+<>sCR
		SEND PACKET:C103($dPontisExp; $text)
		
		CLOSE DOCUMENT:C267($dPontisExp)
	End if 
End if 