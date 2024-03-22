//%attributes = {"shared":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/26/08, 18:40:14
	// ----------------------------------------------------
	// Method: QR_MinElementValue
	// Description
	// Search for the minimum element value of the recently approved inspections.
	// 
	// Parameters
	// $0 : $MinValue_s
	// $1 : $BIN
	// $2 : $ElementNos_txt
	// $3 : $FinalorDBIE_s [Optional] ( "F" | "D")
	// ----------------------------------------------------
	
	Mods_2008_CM_5404
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 

C_TEXT:C284($1; $BIN)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284($0; $MinValue_s; $FinalorDBIE_s)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284($2; $ElementNos_txt)
$BIN:=$1
$ElementNos_txt:=$2
C_BOOLEAN:C305($FinalApp_b)
$FinalApp_b:=True:C214
If (Count parameters:C259>2)
	C_TEXT:C284($3)  // Command Replaced was o_C_STRING length was 1
	If ($3="D")
		$FinalApp_b:=False:C215
	End if 
End if 
ARRAY INTEGER:C220($ElemtNos_ai; 0)
C_TEXT:C284($TestelmNo_txt)
C_LONGINT:C283($CommaPos_L; $currElNo_L)
$CommaPos_L:=Position:C15(","; $ElementNos_txt)
If ($CommaPos_L>0)
	Repeat 
		$TestelmNo_txt:=Substring:C12($ElementNos_txt; 1; ($CommaPos_L-1))
		If (Num:C11($TestelmNo_txt)>0)
			INSERT IN ARRAY:C227($ElemtNos_ai; 1)
			$ElemtNos_ai{1}:=Num:C11($TestelmNo_txt)
		End if 
		$ElementNos_txt:=Substring:C12($ElementNos_txt; ($CommaPos_L+1))
		$CommaPos_L:=Position:C15(","; $ElementNos_txt)
		If ($CommaPos_L<=0)
			$CommaPos_L:=Length:C16($ElementNos_txt)+1
		End if 
	Until ($ElementNos_txt="")
	
Else 
	ARRAY INTEGER:C220($ElemtNos_ai; 1)
	$ElemtNos_ai{1}:=Num:C11($ElementNos_txt)
End if 

$MinValue_s:="N"
SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
QUERY:C277([Inspections:27]; [Inspections:27]BIN:1=$BIN)
If ($FinalApp_b)
	QUERY SELECTION:C341([Inspections:27]; [Inspections:27]InspApproved:167=BMS Approved)
Else 
	QUERY SELECTION:C341([Inspections:27]; [Inspections:27]InspReviewed:12=BMS Approved)
End if 
QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6#"DV@")
If (Records in selection:C76([Inspections:27])>0)
	ORDER BY:C49([Inspections:27]; [Inspections:27]Insp Date:78; <)
	ARRAY DATE:C224($InspDates_aD; 0)
	ARRAY TEXT:C222($InspTypes_aS; 0)  //Command Replaced was o_ARRAY string length was 3
	ARRAY LONGINT:C221($InspIDs_aL; 0)
	C_BOOLEAN:C305($FoundRoutine_b)
	SELECTION TO ARRAY:C260([Inspections:27]Insp Date:78; $InspDates_aD; [Inspections:27]Insp Type:6; $InspTypes_aS; [Inspections:27]InspID:2; $InspIDs_aL)
	C_LONGINT:C283($FirstRoutine_L; $i)
	$FirstRoutine_L:=-1
	For ($i; 1; Size of array:C274($InspIDs_aL))
		If (($InspTypes_aS{$i}="RT@") | ($InspTypes_aS{$i}="CUL"))
			$FirstRoutine_L:=$i
			$i:=Size of array:C274($InspIDs_aL)+1
		End if 
	End for 
	If ($FirstRoutine_L>0)
		ARRAY LONGINT:C221($InspIDs_aL; $FirstRoutine_L)
		QUERY WITH ARRAY:C644([ElementsSafety:29]InspID:4; $InspIDs_aL)
		If (Records in selection:C76([ElementsSafety:29])>0)
			QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]ElementNo:1=$ElemtNos_ai{1}; *)
			For ($i; 2; Size of array:C274($ElemtNos_ai))
				QUERY SELECTION:C341([ElementsSafety:29];  | ; [ElementsSafety:29]ElementNo:1=$ElemtNos_ai{$i}; *)
			End for 
			QUERY SELECTION:C341([ElementsSafety:29])
			If (Records in selection:C76([ElementsSafety:29])>0)
				ARRAY TEXT:C222(QRMINV_ElmRtgs_as; 0)  //Command Replaced was o_ARRAY string length was 1
				ARRAY DATE:C224(QRMINV_elmDate_ad; 0)
				ARRAY INTEGER:C220(QRMINV_ElmNo_ai; 0)
				SELECTION TO ARRAY:C260([ElementsSafety:29]Rating:2; QRMINV_ElmRtgs_as; [Inspections:27]Insp Date:78; QRMINV_elmDate_ad; [ElementsSafety:29]ElementNo:1; QRMINV_ElmNo_ai)
				ARRAY POINTER:C280(QRMINV_sorts_aptr; 3)
				ARRAY LONGINT:C221(QRMINV_Sortor_aL; 3)
				QRMINV_sorts_aptr{1}:=->QRMINV_ElmNo_ai
				QRMINV_sorts_aptr{2}:=->QRMINV_elmDate_ad
				QRMINV_sorts_aptr{3}:=->QRMINV_ElmRtgs_as
				QRMINV_Sortor_aL{1}:=1
				QRMINV_Sortor_aL{2}:=-1
				QRMINV_Sortor_aL{3}:=0
				MULTI SORT ARRAY:C718(QRMINV_sorts_aptr; QRMINV_Sortor_aL)
				$MinValue_s:=QRMINV_ElmRtgs_as{1}
				If (Position:C15($MinValue_s; ";0;1;2;3;4;5;6;7;8;9;N;")<=0)
					$MinValue_s:="N"
				End if 
				$currElNo_L:=QRMINV_ElmNo_ai{1}
				For ($i; 2; Size of array:C274(QRMINV_ElmRtgs_as))
					If (QRMINV_ElmNo_ai{$i}#$currElNo_L)
						If (Position:C15(QRMINV_ElmRtgs_as{$i}; ";0;1;2;3;4;5;6;7;8;9;")>0)
							If ($MinValue_s="N")
								$MinValue_s:=QRMINV_ElmRtgs_as{$i}
							Else 
								If (Num:C11($MinValue_s)>Num:C11(QRMINV_ElmRtgs_as{$i}))
									$MinValue_s:=QRMINV_ElmRtgs_as{$i}
								End if 
							End if 
						End if 
						$currElNo_L:=QRMINV_ElmNo_ai{$i}
						
					End if 
					
				End for 
				
			End if 
			
		End if 
	End if 
End if 

//SET AUTOMATIC RELATIONS(True;True)

$0:=$MinValue_s