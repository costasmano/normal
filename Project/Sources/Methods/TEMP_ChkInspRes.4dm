//%attributes = {"invisible":true}
If (False:C215)
	//GP TEMP_ChkInspRes
	
	//This procedure reports data integrity.
	//It checks whether inspection responsibility matches Item 2, District.
	
	C_LONGINT:C283($i)
	C_TEXT:C284($text; $file)
	C_TIME:C306($CheckRpt)
	$CheckRpt:=Create document:C266("")
	
	If (ok=1)
		
		$text:="Inspection Responsibility Report"+(2*<>sCR)
		SEND PACKET:C103($CheckRpt; $text)
		
		ALL RECORDS:C47([Bridge MHD NBIS:1])
		ORDER BY:C49([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BDEPT:1; [Bridge MHD NBIS:1]Item8:206)
		ARRAY TEXT:C222($aBIN; 0)  //Command Replaced was o_ARRAY string length was 3
		ARRAY TEXT:C222($aBDEPT; 0)  //Command Replaced was o_ARRAY string length was 6
		ARRAY TEXT:C222($aKey; 0)  //Command Replaced was o_ARRAY string length was 15
		ARRAY TEXT:C222($aDistricts; 0)  //Command Replaced was o_ARRAY string length was 2
		ARRAY TEXT:C222($aInspResps; 0)  //Command Replaced was o_ARRAY string length was 5
		
		SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BIN:3; $aBIN; [Bridge MHD NBIS:1]BDEPT:1; $aBDEPT; [Bridge MHD NBIS:1]Item8:206; $aKey)
		SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item2:60; $aDistricts; [Bridge MHD NBIS:1]InspResp:173; $aInspResps)
		
		For ($i; 1; Size of array:C274($aBIN))
			If (Substring:C12($aInspResps{$i}; 1; 4)="DIST")
				If (Num:C11($aDistricts{$i})#Num:C11($aInspResps{$i}))
					$text:=String:C10($i)+<>sTab+$aBIN{$i}+<>sTab+$aBDEPT{$i}+<>sTab+$aKey{$i}+<>sTab+$aDistricts{$i}+"≠"+$aInspResps{$i}+<>sCR
					SEND PACKET:C103($CheckRpt; $text)
				End if 
			End if 
		End for 
		
		CLOSE DOCUMENT:C267($CheckRpt)
		
	End if 
End if 