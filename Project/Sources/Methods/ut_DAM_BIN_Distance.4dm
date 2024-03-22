//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/07/08, 15:24:39
	// ----------------------------------------------------
	// Method: ut_DAM_BIN_Distance
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5403
	Mods_2009_03  //CJM  r001   `03/06/09, 15:14:06`Upgrade from open form window to open window
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
READ ONLY:C145([Bridge MHD NBIS:1])
QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]FHWARecord:174=True:C214)
QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]Item42:85="@5"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  | ; [Bridge MHD NBIS:1]Item42:85="@6"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  | ; [Bridge MHD NBIS:1]Item42:85="@7"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  | ; [Bridge MHD NBIS:1]Item42:85="@8"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  | ; [Bridge MHD NBIS:1]Item42:85="@9")
ARRAY TEXT:C222(UnitsList_as; 0)

C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l; $i; $newlinecount_L; $iB)
C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
C_TEXT:C284($Title_txt)
FORM GET PROPERTIES:C674([Dialogs:21]; "LatLongControl"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
//$newin:=Open form window([Dialogs];"LatLongControl")
DIALOG:C40([Dialogs:21]; "LatLongControl")
CLOSE WINDOW:C154
If (OK=1)
	C_TIME:C306($inputFile_f; $outputfile_f)
	ARRAY TEXT:C222($LineInfo_atxt; MaxArraySize)
	ARRAY REAL:C219($DamLat_ar; MaxArraySize)
	ARRAY REAL:C219($DamLon_ar; MaxArraySize)
	C_TEXT:C284($tBuffer; $HeaderLine_txt)
	C_LONGINT:C283($linecount_L; $TabPos_L)
	C_BOOLEAN:C305($LineInfo_b)
	$LineInfo_b:=False:C215
	$linecount_L:=0
	$inputFile_f:=Open document:C264(SourceFile_txt; "TEXT"; Read mode:K24:5)
	If (File_Header=1)
		RECEIVE PACKET:C104($inputFile_f; $HeaderLine_txt; <>sCR)
	End if 
	If (OK=1)
		RECEIVE PACKET:C104($inputFile_f; $tBuffer; <>sCR)
		While (OK=1)
			$linecount_L:=$linecount_L+1
			$TabPos_L:=Position:C15(<>sTAB; $tbuffer)
			$DamLat_ar{$linecount_L}:=Abs:C99(Num:C11(Substring:C12($tBuffer; 1; ($TabPos_L-1))))
			$tbuffer:=Substring:C12($tBuffer; $TabPos_L+1)
			$TabPos_L:=Position:C15(<>sTAB; $tbuffer)
			If ($TabPos_L>0)
				$DamLon_ar{$linecount_L}:=Abs:C99(Num:C11(Substring:C12($tBuffer; 1; ($TabPos_L-1))))
				$LineInfo_atxt{$linecount_L}:=Substring:C12($tBuffer; $TabPos_L+1)
				$LineInfo_b:=True:C214
			Else 
				$DamLon_ar{$linecount_L}:=Abs:C99(Num:C11($tBuffer))
			End if 
			RECEIVE PACKET:C104($inputFile_f; $tBuffer; <>sCR)
		End while 
	End if 
	CLOSE DOCUMENT:C267($inputFile_f)
	ARRAY TEXT:C222($LineInfo_atxt; $linecount_L)
	ARRAY REAL:C219($DamLat_ar; $linecount_L)
	ARRAY REAL:C219($DamLon_ar; $linecount_L)
	//Reference arrays to help in quicker searches
	ARRAY REAL:C219(DamLatRef_ar; $linecount_L)
	ARRAY LONGINT:C221(DamIndx_aL; $linecount_L)
	For ($i; 1; $linecount_L)
		DamIndx_aL{$i}:=$i
	End for 
	COPY ARRAY:C226($DamLat_ar; DamLatRef_ar)
	//first remove any zeroes
	SORT ARRAY:C229(DamLatRef_ar; DamIndx_aL; <)
	For ($i; $linecount_L; 1; -1)
		If (DamLatRef_ar{$i}=0)
			
		Else 
			$newlinecount_L:=$i
			$i:=0
		End if 
		
	End for 
	ARRAY REAL:C219(DamLatRef_ar; $newlinecount_L)
	ARRAY LONGINT:C221(DamIndx_aL; $newlinecount_L)
	SORT ARRAY:C229(DamLatRef_ar; DamIndx_aL)
	//Do the header
	If (File_header=0)
		$HeaderLine_txt:="Lat."+<>sTAB+"Long."
		If ($LineInfo_b)
			$HeaderLine_txt:=$HeaderLine_txt+<>sTAB+"Info"
		End if 
	End if 
	
	C_REAL:C285($CenterLat_r; $CenterLon_r; $BridgeLat_r; $BridgeLon_r; $Radius; $BrDist_R; $RFactor)
	//Convert radius to miles
	$RFactor:=1
	Case of 
		: (UnitsList_as{UnitsList_as}="Feet")
			$RFactor:=0.00018939394
		: (UnitsList_as{UnitsList_as}="Meters")
			$RFactor:=0.00062137119
		: (UnitsList_as{UnitsList_as}="KiloMeters")
			$RFactor:=0.62137119
	End case 
	
	$Radius:=vRadiusR*$RFactor
	$outputfile_f:=Create document:C266(""; "TEXT")
	If (OK=1)
		//Make up the header
		C_TEXT:C284($BridgeFldHeader_txt)
		$BridgeFldHeader_txt:=Field name:C257(->[Bridge MHD NBIS:1]BDEPT:1)+<>sTAB+Field name:C257(->[Bridge MHD NBIS:1]BIN:3)+<>sTAB
		$BridgeFldHeader_txt:=$BridgeFldHeader_txt+Field name:C257(->[Bridge MHD NBIS:1]Town Name:175)+<>sTAB+Field name:C257(->[Bridge MHD NBIS:1]Item7:65)+<>sTAB
		$BridgeFldHeader_txt:=$BridgeFldHeader_txt+Field name:C257(->[Bridge MHD NBIS:1]Item6A:63)+<>sTAB+Field name:C257(->[Bridge MHD NBIS:1]Item16A:68)+<>sTAB
		$BridgeFldHeader_txt:=$BridgeFldHeader_txt+Field name:C257(->[Bridge MHD NBIS:1]Item16B:69)+<>sTAB+Field name:C257(->[Bridge MHD NBIS:1]Item16C:109)+<>sTAB
		$BridgeFldHeader_txt:=$BridgeFldHeader_txt+Field name:C257(->[Bridge MHD NBIS:1]Item17A:70)+<>sTAB+Field name:C257(->[Bridge MHD NBIS:1]Item17B:71)+<>sTAB
		$BridgeFldHeader_txt:=$BridgeFldHeader_txt+Field name:C257(->[Bridge MHD NBIS:1]Item17C:136)+<>sTAB
		SEND PACKET:C103($outputfile_f; ($BridgeFldHeader_txt+$HeaderLine_txt+<>sTAB+"Distance"+<>sCR))
		SHORT_MESSAGE("Searching thru "+String:C10(Records in selection:C76([Bridge MHD NBIS:1]))+" BINs...")
		ARRAY TEXT:C222($BDEPTS_as; 0)  //Command Replaced was o_ARRAY string length was 6
		ARRAY TEXT:C222($BINS_as; 0)  //Command Replaced was o_ARRAY string length was 3
		ARRAY TEXT:C222($BTwn_as; 0)  //Command Replaced was o_ARRAY string length was 20
		ARRAY INTEGER:C220($B16A_ai; 0)
		ARRAY INTEGER:C220($B16B_ai; 0)
		ARRAY INTEGER:C220($B17A_ai; 0)
		ARRAY INTEGER:C220($B17B_ai; 0)
		ARRAY REAL:C219($B16C_ar; 0)
		ARRAY REAL:C219($B17C_ar; 0)
		MESSAGE:C88("Loading arrays ...")
		SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BDEPT:1; $BDEPTS_as; [Bridge MHD NBIS:1]BIN:3; $BINS_as; [Bridge MHD NBIS:1]Town Name:175; $BTwn_as)
		SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item16A:68; $B16A_ai; [Bridge MHD NBIS:1]Item16B:69; $B16B_ai; [Bridge MHD NBIS:1]Item16C:109; $B16C_ar)
		SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item17A:70; $B17A_ai; [Bridge MHD NBIS:1]Item17B:71; $B17B_ai; [Bridge MHD NBIS:1]Item17C:136; $B17C_ar)
		C_REAL:C285(BINMinLat_r; BINMaxLat_r; $DeltaLat_r)
		C_LONGINT:C283($Startindx_L; $EndIndx_L)
		$DeltaLat_r:=($Radius/3963)*(180/Pi:K30:1)
		For ($iB; 1; Size of array:C274($BINS_as))
			$BridgeLat_r:=$B16A_ai{$iB}+($B16B_ai{$iB}/60)+($B16C_ar{$iB}/(60*60))
			$BridgeLon_r:=$B17A_ai{$iB}+($B17B_ai{$iB}/60)+($B17C_ar{$iB}/(60*60))
			BINMinLat_r:=$BridgeLat_r-$DeltaLat_r
			BINMaxLat_r:=$BridgeLat_r+$DeltaLat_r
			$Startindx_L:=F_FindMinIndx(->BINMinLat_r; ->DamLatRef_ar)
			$EndIndx_L:=F_FindMaxIndx(->BINMaxLat_r; ->DamLatRef_ar)
			MESSAGE:C88(String:C10($iB)+"...")
			For ($i; $Startindx_L; $EndIndx_L)
				If (($DamLat_ar{DamIndx_aL{$i}}>0) & ($DamLon_ar{DamIndx_aL{$i}}>0))
					$BrDist_R:=F_MDistance($DamLat_ar{DamIndx_aL{$i}}; $DamLon_ar{DamIndx_aL{$i}}; $BridgeLat_r; $BridgeLon_r)
					If ($BrDist_R<=$Radius)
						GOTO SELECTED RECORD:C245([Bridge MHD NBIS:1]; $iB)
						$tBuffer:=$BDEPTS_as{$iB}+<>sTAB+$BINS_as{$iB}+<>sTAB+$BTwn_as{$iB}+<>sTAB+[Bridge MHD NBIS:1]Item7:65+<>sTAB
						$tBuffer:=$tBuffer+[Bridge MHD NBIS:1]Item6A:63+<>sTAB+String:C10($B16A_ai{$iB})+<>sTAB+String:C10($B16B_ai{$iB})+<>sTAB
						$tBuffer:=$tBuffer+String:C10($B16C_ar{$iB})+<>sTAB+String:C10($B17A_ai{$iB})+<>sTAB
						$tBuffer:=$tBuffer+String:C10($B17B_ai{$iB})+<>sTAB+String:C10($B17C_ar{$iB})+<>sTAB
						$tBuffer:=$tBuffer+String:C10($DamLat_ar{DamIndx_aL{$i}})+<>sTAB+String:C10($DamLon_ar{DamIndx_aL{$i}})+<>sTAB
						$tBuffer:=$tBuffer+$LineInfo_atxt{DamIndx_aL{$i}}+<>sTAB+String:C10($BrDist_R/$RFactor)+<>sCR
						SEND PACKET:C103($outputfile_f; $tBuffer)
					End if 
				End if 
			End for 
			If (False:C215)
			Else 
			End if 
		End for 
		ARRAY TEXT:C222($BDEPTS_as; 0)  //Command Replaced was o_ARRAY string length was 6
		ARRAY TEXT:C222($BINS_as; 0)  //Command Replaced was o_ARRAY string length was 3
		ARRAY TEXT:C222($BTwn_as; 0)  //Command Replaced was o_ARRAY string length was 20
		ARRAY INTEGER:C220($B16A_ai; 0)
		ARRAY INTEGER:C220($B16B_ai; 0)
		ARRAY INTEGER:C220($B17A_ai; 0)
		ARRAY INTEGER:C220($B17B_ai; 0)
		ARRAY REAL:C219($B16C_ar; 0)
		ARRAY REAL:C219($B17C_ar; 0)
		ARRAY TEXT:C222($LineInfo_atxt; 0)
		ARRAY REAL:C219($DamLat_ar; 0)
		ARRAY REAL:C219($DamLon_ar; 0)
		
		ARRAY TEXT:C222(UnitsList_as; 0)
		
		//Reference arrays to help in quicker searches
		ARRAY REAL:C219(DamLatRef_ar; 0)
		ARRAY LONGINT:C221(DamIndx_aL; 0)
		
		CLOSE WINDOW:C154
		CLOSE DOCUMENT:C267($outputfile_f)
	Else 
		ALERT:C41("Cannot proceed without output file!!!")
	End if 
	
End if 

READ WRITE:C146([Bridge MHD NBIS:1])