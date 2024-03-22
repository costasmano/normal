//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/22/08, 08:43:00
	// ----------------------------------------------------
	// Method: ut_compareLatLong
	// Description
	// Compare Lat/Longs stored in the DB with Lat/Longs in a text file by BIN.
	// The Lat/Longs are expected to be in decimal degrees.
	// The first line of the file should contain the headers, BIN, Latit(ude), Longit(ude)
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5403
End if 
C_TIME:C306($InputFile)
$InputFile:=Open document:C264(""; Read mode:K24:5)
If (OK=1)
	C_TEXT:C284($TBuffer; $ColHeader)
	C_LONGINT:C283($BinCol_L; $LatCol_L; $LongCol_L; $TabPos_L; $ColCount_L)
	RECEIVE PACKET:C104($InputFile; $TBuffer; <>sCR)
	$TBuffer:=Replace string:C233($TBuffer; <>sLF; "")
	$ColCount_L:=0
	While ($TBuffer#"")
		$TabPos_L:=Position:C15(<>sTAB; $TBuffer)
		If ($TabPos_L>0)
			
		Else 
			$TabPos_L:=(Length:C16($TBuffer)+1)
		End if 
		$ColCount_L:=$ColCount_L+1
		$ColHeader:=Substring:C12($TBuffer; 1; ($TabPos_L-1))
		$TBuffer:=Substring:C12($TBuffer; ($TabPos_L+1))
		Case of 
			: ($ColHeader="BIN")
				$BinCol_L:=$ColCount_L
			: ($ColHeader="Latit@")
				$LatCol_L:=$ColCount_L
			: ($ColHeader="Longit@")
				$LongCol_L:=$ColCount_L
		End case 
	End while 
	If (($BinCol_L>0) & ($LatCol_L>0) & ($LongCol_L>0))
		ARRAY TEXT:C222($columns_atxt; $ColCount_L)
		$errFile:=Create document:C266(""; "TEXT")
		$tBuffer:="BIN"+<>sTAB+"InputLat"+<>sTAB+"InputLong"+<>sTAB+"BIN Lat"+<>sTAB+"BIN Long"
		$tBuffer:=$tBuffer+<>sTAB+"Input Lat Deg"+<>sTAB+"Input Lat Min"+<>sTAB+"Inpu tLat Sec"
		$tBuffer:=$tBuffer+<>sTAB+"Input Long Deg"+<>sTAB+"Input Long Min"+<>sTAB+"Input Long Sec"
		$tBuffer:=$tBuffer+<>sTAB+"16A"+<>sTAB+"16B"+<>sTAB+"16C"
		$tBuffer:=$tBuffer+<>sTAB+"17A"+<>sTAB+"17B"+<>sTAB+"17C"
		$tBuffer:=$tBuffer+<>sTAB+"Lat Diff Deg"+<>sTAB+"Long Diff Deg"+<>sCR
		SEND PACKET:C103($errFile; $tBuffer)
		
		RECEIVE PACKET:C104($InputFile; $TBuffer; <>sCR)
		C_TEXT:C284($BIN)  // Command Replaced was o_C_STRING length was 3
		C_BOOLEAN:C305($Going_b)
		C_REAL:C285($LatVal_r; $LongVal_r; $BINLat_r; $BINLong_r; $LatDiff_r; $LongDiff_r; $DiffMar_r; $mSec)
		C_LONGINT:C283($mdeg; $mMin; $i; $ErrCount_L; $lineCount_L)
		$ErrCount_L:=0
		$lineCount_L:=0
		C_TIME:C306($errFile)
		C_TEXT:C284($numf)
		$numf:="####0.000000000000"
		$DiffMar_r:=(0.1/3600)
		$Going_b:=True:C214
		SHORT_MESSAGE("Scanning File ....")
		While ($Going_b)
			$lineCount_L:=$lineCount_L+1
			For ($i; 1; $ColCount_L)
				$TabPos_L:=Position:C15(<>sTAB; $TBuffer)
				If ($TabPos_L>0)
				Else 
					$TabPos_L:=(Length:C16($TBuffer)+1)
				End if 
				$columns_atxt{$i}:=Substring:C12($TBuffer; 1; ($TabPos_L-1))
				$TBuffer:=Substring:C12($TBuffer; ($TabPos_L+1))
			End for 
			$BIN:=$columns_atxt{$BinCol_L}
			$LatVal_r:=Abs:C99(Num:C11($columns_atxt{$LatCol_L}))
			$LongVal_r:=Abs:C99(Num:C11($columns_atxt{$LongCol_L}))
			QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$BIN)
			If (Records in selection:C76([Bridge MHD NBIS:1])=1)
				$BINLat_r:=[Bridge MHD NBIS:1]Item16A:68+([Bridge MHD NBIS:1]Item16B:69/60)+([Bridge MHD NBIS:1]Item16C:109/3600)
				$BINLong_r:=[Bridge MHD NBIS:1]Item17A:70+([Bridge MHD NBIS:1]Item17B:71/60)+([Bridge MHD NBIS:1]Item17C:136/3600)
				$LatDiff_r:=$LatVal_r-$BINLat_r
				$LongDiff_r:=$LongVal_r-$BINLong_r
				If (($LatDiff_r>$DiffMar_r) | ($LongDiff_r>$DiffMar_r))
					$tBuffer:=$BIN+<>sTAB+String:C10($LatVal_r; $numf)+<>sTAB+String:C10($LongVal_r; $numf)+<>sTAB+String:C10($BINLat_r; $numf)+<>sTAB+String:C10($BINLong_r; $numf)
					$mdeg:=Int:C8($LatVal_r)
					$mMin:=Int:C8(($LatVal_r-$mdeg)*60)
					$mSec:=($LatVal_r-$mdeg-($mMin/60))*3600
					$tBuffer:=$tBuffer+<>sTAB+String:C10($mdeg)+<>sTAB+String:C10($mMin)+<>sTAB+String:C10($mSec; $numf)
					$mdeg:=Int:C8($LongVal_r)
					$mMin:=Int:C8(($LongVal_r-$mdeg)*60)
					$mSec:=($LongVal_r-$mdeg-($mMin/60))*3600
					$tBuffer:=$tBuffer+<>sTAB+String:C10($mdeg)+<>sTAB+String:C10($mMin)+<>sTAB+String:C10($mSec; $numf)
					$tBuffer:=$tBuffer+<>sTAB+String:C10([Bridge MHD NBIS:1]Item16A:68)+<>sTAB+String:C10([Bridge MHD NBIS:1]Item16B:69)+<>sTAB+String:C10([Bridge MHD NBIS:1]Item16C:109; $numf)
					$tBuffer:=$tBuffer+<>sTAB+String:C10([Bridge MHD NBIS:1]Item17A:70)+<>sTAB+String:C10([Bridge MHD NBIS:1]Item17B:71)+<>sTAB+String:C10([Bridge MHD NBIS:1]Item17C:136; $numf)
					$tBuffer:=$tBuffer+<>sTAB+String:C10($LatDiff_r; $numf)+<>sTAB+String:C10($LongDiff_r; $numf)+<>sCR
					SEND PACKET:C103($errFile; $tBuffer)
					$ErrCount_L:=$ErrCount_L+1
				End if 
				
			Else 
				ALERT:C41("Could not find BIN "+$BIN)
			End if 
			
			RECEIVE PACKET:C104($InputFile; $TBuffer; <>sCR)
			If (OK=1)
			Else 
				If ($TBuffer="")
					$Going_b:=False:C215
				End if 
				
			End if 
			
		End while 
		CLOSE DOCUMENT:C267($errFile)
		CLOSE WINDOW:C154
		ARRAY TEXT:C222($columns_atxt; 0)
		ALERT:C41("From "+String:C10($lineCount_L)+" lines read  Found "+String:C10($ErrCount_L)+" Bins with mismatched LatLongs")
	Else 
		ALERT:C41("BIN, or Latit@, or Longit@ columns not found!")
	End if 
	
	CLOSE DOCUMENT:C267($InputFile)
End if 