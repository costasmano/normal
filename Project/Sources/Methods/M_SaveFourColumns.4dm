//%attributes = {"invisible":true}
C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($Recs)
C_TIME:C306($vhDocRef)
C_TEXT:C284($text)  // Command Replaced was o_C_STRING length was 20

$Recs:=Records in selection:C76([Conslt Rating:63])

If ($Recs>0)
	$vhDocRef:=Create document:C266("")
	If (OK=1)
		SEND PACKET:C103($vhDocRef; "District"+<>sTab)
		SEND PACKET:C103($vhDocRef; "City/Town Name"+<>sTab)
		SEND PACKET:C103($vhDocRef; "Item 8"+<>sTab)
		SEND PACKET:C103($vhDocRef; "BIN"+<>sTab+<>sCR)
		
		FIRST RECORD:C50([Conslt Rating:63])
		For ($i; 1; $Recs)
			RELATE ONE:C42([Conslt Rating:63]BIN:1)
			SEND PACKET:C103($vhDocRef; [Bridge MHD NBIS:1]Item2:60+<>sTab)
			SEND PACKET:C103($vhDocRef; [Bridge MHD NBIS:1]Town Name:175+<>sTab)
			$text:=Insert string:C231([Bridge MHD NBIS:1]BDEPT:1; "-"; 2)
			$text:=Insert string:C231($text; "-"; 5)
			SEND PACKET:C103($vhDocRef; $text+<>sTab)
			SEND PACKET:C103($vhDocRef; [Conslt Rating:63]BIN:1+<>sTab+<>sCR)
			NEXT RECORD:C51([Conslt Rating:63])
		End for 
		CLOSE DOCUMENT:C267($vhDocRef)
	End if 
	
Else 
	
	BEEP:C151
	ALERT:C41("No records have been selected!")
	
End if 