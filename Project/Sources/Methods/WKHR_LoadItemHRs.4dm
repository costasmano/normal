//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/19/05, 20:21:59
	// ----------------------------------------------------
	// Method: WKHR_LoadItemHRs
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM21
	// Modified by: costasmanousakis-(Designer)-06/19/08, 08:37:55
	Mods_2008_CM_5403  //("WKHRS")
	// Modified by: costasmanousakis-(Designer)-(1/3/09 22:07:05)
	Mods_2009_CM_5404  //("WKHRMODS")
	Mods_2012_02  //r002   `Fix bug where resolve pointer not retuning corect data
	//Modified by: Charles Miller (2/9/12 14:43:44)
End if 
C_POINTER:C301(arrPtr_1; arrPtr_2; arrPtr_3; arrPtr_4)
C_REAL:C285(wkhr_PgTotal_1; wkhr_PgTotal_2; wkhr_PgTotal_3; wkhr_PgTotal_4; wkhr_PgTotal_5; wkhr_PgTotal_6; wkhr_PgTotal_7)
ut_ZeroByPointer("wkhr_PgTotal_$Loop"; 1; 7)
C_REAL:C285(wkhr_PgTotal0_1; wkhr_PgTotal0_2; wkhr_PgTotal0_3; wkhr_PgTotal0_4; wkhr_PgTotal0_5; wkhr_PgTotal0_6; wkhr_PgTotal0_7)
ut_ZeroByPointer("wkhr_PgTotal0_$Loop"; 1; 7)
C_REAL:C285(wkhr_RevPgTotal_1; wkhr_RevPgTotal_2; wkhr_RevPgTotal_3; wkhr_RevPgTotal_4; wkhr_RevPgTotal_5; wkhr_RevPgTotal_6; wkhr_RevPgTotal_7)
ut_ZeroByPointer("wkhr_RevPgTotal_$Loop"; 1; 7)
C_REAL:C285(wkhr_OffEstPgTotal_1; wkhr_OffEstPgTotal_2; wkhr_OffEstPgTotal_3; wkhr_OffEstPgTotal_4; wkhr_OffEstPgTotal_5; wkhr_OffEstPgTotal_6; wkhr_OffEstPgTotal_7)
ut_ZeroByPointer("wkhr_OffEstPgTotal_$Loop"; 1; 7)

ARRAY TEXT:C222(Arr_ItemNos; 0)
ARRAY TEXT:C222(Arr_ItemDesc; 0)
ARRAY REAL:C219(Arr_Values_1; 0)
ARRAY REAL:C219(Arr_Values_2; 0)
ARRAY REAL:C219(Arr_Values_3; 0)
ARRAY REAL:C219(Arr_Values_4; 0)
ARRAY REAL:C219(Arr_Values_5; 0)
ARRAY REAL:C219(Arr_Values_6; 0)
ARRAY REAL:C219(Arr_Values_7; 0)
ARRAY TEXT:C222(Arr_BreakDown; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(Arr_RevCmts; 0)  //Command Replaced was o_ARRAY string length was 2

arrPtr_1:=Get pointer:C304("Arr_"+CategoryPrefix+"_1")
arrPtr_2:=Get pointer:C304("Arr_"+CategoryPrefix+"_2")
arrPtr_3:=Get pointer:C304("Arr_"+CategoryPrefix+"_Values")
arrPtr_4:=Get pointer:C304("Arr_"+CategoryPrefix+"_Totals")

COPY ARRAY:C226(arrPtr_1->; Arr_ItemNos)
COPY ARRAY:C226(arrPtr_2->; Arr_ItemDesc)
COPY ARRAY:C226(arrPtr_3->{1}; Arr_Values_1)
COPY ARRAY:C226(arrPtr_3->{2}; Arr_Values_2)
COPY ARRAY:C226(arrPtr_3->{3}; Arr_Values_3)
COPY ARRAY:C226(arrPtr_3->{4}; Arr_Values_4)
COPY ARRAY:C226(arrPtr_3->{5}; Arr_Values_5)
COPY ARRAY:C226(arrPtr_3->{6}; Arr_Values_6)
If ([Work_Estimate:103]Version_L:47>0)
	COPY ARRAY:C226(arrPtr_3->{7}; Arr_Values_7)
Else 
	ARRAY REAL:C219(Arr_Values_7; Size of array:C274(Arr_Values_1))
End if 

C_LONGINT:C283($NumItems_L; $i; $PosInRestricted_L)
$NumItems_L:=Size of array:C274(Arr_ItemNos)
For ($i; $NumItems_L; 1; -1)
	$PosInRestricted_L:=Find in array:C230(Arr_WKHR_RestrictedSubItms_I; Num:C11(Arr_ItemNos{$i}))
	If ($PosInRestricted_L>0)
		DELETE FROM ARRAY:C228(Arr_ItemNos; $i)
		DELETE FROM ARRAY:C228(Arr_ItemDesc; $i)
		DELETE FROM ARRAY:C228(Arr_Values_1; $i)
		DELETE FROM ARRAY:C228(Arr_Values_2; $i)
		DELETE FROM ARRAY:C228(Arr_Values_3; $i)
		DELETE FROM ARRAY:C228(Arr_Values_4; $i)
		DELETE FROM ARRAY:C228(Arr_Values_5; $i)
		DELETE FROM ARRAY:C228(Arr_Values_6; $i)
		DELETE FROM ARRAY:C228(Arr_Values_7; $i)
	End if 
	
End for 
$NumItems_L:=Size of array:C274(Arr_ItemNos)
ARRAY TEXT:C222(Arr_BreakDown; $NumItems_L)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(Arr_RevCmts; $NumItems_L)  //Command Replaced was o_ARRAY string length was 2
C_LONGINT:C283($PosInBrkDwn; $PosInRevCmts)
For ($i; 1; $NumItems_L)
	$PosInBrkDwn:=Find in array:C230(Arr_WKHR_SubItmRef; Num:C11(Arr_ItemNos{$i}))
	$PosInRevCmts:=Find in array:C230(Arr_WKHR_ReviewRef; Num:C11(Arr_ItemNos{$i}))
	If ($PosInBrkDwn>0)
		Arr_BreakDown{$i}:=Char:C90(195)
	Else 
		Arr_BreakDown{$i}:=Char:C90(0)
	End if 
	If ($PosInRevCmts>0)
		Arr_RevCmts{$i}:=Char:C90(120)
	Else 
		Arr_RevCmts{$i}:=Char:C90(0)
	End if 
	
End for 

Arr_ItemNos:=0
Arr_ItemDesc:=0
Arr_Values_1:=0
Arr_Values_2:=0
Arr_Values_3:=0
Arr_Values_4:=0
Arr_Values_5:=0
Arr_Values_6:=0
Arr_Values_7:=0

Arr_BreakDown:=0
Arr_RevCmts:=0

wkhr_PgTotal_1:=arrPtr_4->{1}
wkhr_PgTotal_2:=arrPtr_4->{2}
wkhr_PgTotal_3:=arrPtr_4->{3}
wkhr_PgTotal_4:=arrPtr_4->{4}
wkhr_PgTotal_5:=arrPtr_4->{5}
wkhr_PgTotal_6:=arrPtr_4->{6}
If ([Work_Estimate:103]Version_L:47>0)
	wkhr_PgTotal_7:=arrPtr_4->{7}
End if 
C_LONGINT:C283($RevIndx)
$RevIndx:=Find in array:C230(Arr_WKHR_ReviewRef; Num:C11(CategoryPrefix))
If ($RevIndx>0)
	wkhr_RevPgTotal_1:=arr_WKHR_ReviewVal{1}{$RevIndx}
	wkhr_RevPgTotal_2:=arr_WKHR_ReviewVal{2}{$RevIndx}
	wkhr_RevPgTotal_3:=arr_WKHR_ReviewVal{3}{$RevIndx}
	wkhr_RevPgTotal_4:=arr_WKHR_ReviewVal{4}{$RevIndx}
	wkhr_RevPgTotal_5:=arr_WKHR_ReviewVal{5}{$RevIndx}
	wkhr_RevPgTotal_6:=arr_WKHR_ReviewVal{6}{$RevIndx}
	If ([Work_Estimate:103]Version_L:47>0)
		wkhr_RevPgTotal_7:=arr_WKHR_ReviewVal{7}{$RevIndx}
	End if 
	$NumItems_L:=Size of array:C274(Arr_ItemNos)
	For ($i; $NumItems_L; 1; -1)
		$RevIndx:=Find in array:C230(Arr_WKHR_ReviewRef; Num:C11(Arr_ItemNos{$i}))
		If ($RevIndx>0)
			INSERT IN ARRAY:C227(Arr_ItemNos; ($i+1))
			INSERT IN ARRAY:C227(Arr_ItemDesc; ($i+1))
			INSERT IN ARRAY:C227(Arr_Values_1; ($i+1))
			INSERT IN ARRAY:C227(Arr_Values_2; ($i+1))
			INSERT IN ARRAY:C227(Arr_Values_3; ($i+1))
			INSERT IN ARRAY:C227(Arr_Values_4; ($i+1))
			INSERT IN ARRAY:C227(Arr_Values_5; ($i+1))
			INSERT IN ARRAY:C227(Arr_Values_6; ($i+1))
			INSERT IN ARRAY:C227(Arr_Values_7; ($i+1))
			INSERT IN ARRAY:C227(Arr_BreakDown; ($i+1))
			INSERT IN ARRAY:C227(Arr_RevCmts; ($i+1))
			Arr_ItemNos{$i+1}:=Arr_ItemNos{$i}
			Arr_ItemDesc{$i+1}:="     (Reviewer Edits)"
			Arr_Values_1{$i+1}:=arr_WKHR_ReviewVal{1}{$RevIndx}
			Arr_Values_2{$i+1}:=arr_WKHR_ReviewVal{2}{$RevIndx}
			Arr_Values_3{$i+1}:=arr_WKHR_ReviewVal{3}{$RevIndx}
			Arr_Values_4{$i+1}:=arr_WKHR_ReviewVal{4}{$RevIndx}
			Arr_Values_5{$i+1}:=arr_WKHR_ReviewVal{5}{$RevIndx}
			Arr_Values_6{$i+1}:=arr_WKHR_ReviewVal{6}{$RevIndx}
			If ([Work_Estimate:103]Version_L:47>0)
				Arr_Values_7{$i+1}:=arr_WKHR_ReviewVal{7}{$RevIndx}
			End if 
			Arr_BreakDown{$i+1}:=Char:C90(0)
			Arr_RevCmts{$i+1}:=Char:C90(0)
		End if 
		
	End for 
	
Else 
	ut_ZeroByPointer("wkhr_RevPgTotal_$Loop"; 1; 7)
End if 

If (WKHR_OfficeEstView_b)
	$RevIndx:=Find in array:C230(Arr_WKHR_OfficeEstRef; Num:C11(CategoryPrefix))
	If ($RevIndx>0)
		wkhr_OffEstPgTotal_1:=arr_WKHR_OfficeEstVal{1}{$RevIndx}
		wkhr_OffEstPgTotal_2:=arr_WKHR_OfficeEstVal{2}{$RevIndx}
		wkhr_OffEstPgTotal_3:=arr_WKHR_OfficeEstVal{3}{$RevIndx}
		wkhr_OffEstPgTotal_4:=arr_WKHR_OfficeEstVal{4}{$RevIndx}
		wkhr_OffEstPgTotal_5:=arr_WKHR_OfficeEstVal{5}{$RevIndx}
		wkhr_OffEstPgTotal_6:=arr_WKHR_OfficeEstVal{6}{$RevIndx}
		If ([Work_Estimate:103]Version_L:47>0)
			wkhr_OffEstPgTotal_7:=arr_WKHR_OfficeEstVal{7}{$RevIndx}
		End if 
		$NumItems_L:=Size of array:C274(Arr_ItemNos)
		C_LONGINT:C283($insertPos_L)
		For ($i; $NumItems_L; 1; -1)
			$RevIndx:=Find in array:C230(Arr_WKHR_OfficeEstRef; Num:C11(Arr_ItemNos{$i}))
			If ($RevIndx>0)
				If (Position:C15("(Reviewer Edits)"; Arr_ItemDesc{$i})>0)
					$insertPos_L:=$i+1
					$i:=$i-1
				Else 
					$insertPos_L:=$i+1
				End if 
				INSERT IN ARRAY:C227(Arr_ItemNos; $insertPos_L)
				INSERT IN ARRAY:C227(Arr_ItemDesc; $insertPos_L)
				INSERT IN ARRAY:C227(Arr_Values_1; $insertPos_L)
				INSERT IN ARRAY:C227(Arr_Values_2; $insertPos_L)
				INSERT IN ARRAY:C227(Arr_Values_3; $insertPos_L)
				INSERT IN ARRAY:C227(Arr_Values_4; $insertPos_L)
				INSERT IN ARRAY:C227(Arr_Values_5; $insertPos_L)
				INSERT IN ARRAY:C227(Arr_Values_6; $insertPos_L)
				INSERT IN ARRAY:C227(Arr_Values_7; $insertPos_L)
				INSERT IN ARRAY:C227(Arr_BreakDown; $insertPos_L)
				INSERT IN ARRAY:C227(Arr_RevCmts; $insertPos_L)
				Arr_ItemNos{$insertPos_L}:=Arr_ItemNos{$i}
				Arr_ItemDesc{$insertPos_L}:="     (Office Estimate)"
				Arr_Values_1{$insertPos_L}:=arr_WKHR_OfficeEstVal{1}{$RevIndx}
				Arr_Values_2{$insertPos_L}:=arr_WKHR_OfficeEstVal{2}{$RevIndx}
				Arr_Values_3{$insertPos_L}:=arr_WKHR_OfficeEstVal{3}{$RevIndx}
				Arr_Values_4{$insertPos_L}:=arr_WKHR_OfficeEstVal{4}{$RevIndx}
				Arr_Values_5{$insertPos_L}:=arr_WKHR_OfficeEstVal{5}{$RevIndx}
				Arr_Values_6{$insertPos_L}:=arr_WKHR_OfficeEstVal{6}{$RevIndx}
				If ([Work_Estimate:103]Version_L:47>0)
					Arr_Values_7{$insertPos_L}:=arr_WKHR_OfficeEstVal{7}{$RevIndx}
				End if 
				Arr_BreakDown{$insertPos_L}:=Char:C90(0)
				Arr_RevCmts{$insertPos_L}:=Char:C90(0)
				
			End if 
			
		End for 
		
	Else 
		ut_ZeroByPointer("wkhr_OffEstPgTotal_$Loop"; 1; 7)
	End if 
	
End if 
If (WKHR_OrigEstView_b)
	//Original estimates go after the review comments if any- if not after the main item
	C_POINTER:C301(arrPtr0_1; arrPtr0_3; arrPtr0_4)
	arrPtr0_1:=Get pointer:C304("Arr0_"+CategoryPrefix+"_1")
	C_TEXT:C284($VaidPtrTest)
	C_LONGINT:C283($ValiptrFldTest; $ValiptrTblTest)
	C_BOOLEAN:C305($btOK)
	$btOK:=(Type:C295(arrPtr0_1->)#5)
	//RESOLVE POINTER(arrPtr0_1;$VaidPtrTest;$ValiptrFldTest;$ValiptrTblTest)
	If ($btOK)  //($VaidPtrTest=("Arr0_"+CategoryPrefix+"_1"))
		C_LONGINT:C283($OrigIndx; $Posindx)
		arrPtr0_3:=Get pointer:C304("Arr0_"+CategoryPrefix+"_Values")
		arrPtr0_4:=Get pointer:C304("Arr0_"+CategoryPrefix+"_Totals")
		
		For ($i; 1; Size of array:C274(arrPtr_1->))
			$OrigIndx:=Find in array:C230(arrPtr0_1->; arrPtr_1->{$i})
			If ($OrigIndx>0)
				If ((arrPtr0_3->{6}{$OrigIndx})>0)
					$Posindx:=Find in array:C230(Arr_ItemNos; arrPtr0_1->{$OrigIndx})
					If ($Posindx>0)
						$RevIndx:=Find in array:C230(Arr_WKHR_ReviewRef; Num:C11(arrPtr0_1->{$OrigIndx}))
						If ($RevIndx>0)
							//there is
							$Posindx:=$Posindx+1
						End if 
						INSERT IN ARRAY:C227(Arr_ItemNos; ($Posindx+1))
						INSERT IN ARRAY:C227(Arr_ItemDesc; ($Posindx+1))
						INSERT IN ARRAY:C227(Arr_Values_1; ($Posindx+1))
						INSERT IN ARRAY:C227(Arr_Values_2; ($Posindx+1))
						INSERT IN ARRAY:C227(Arr_Values_3; ($Posindx+1))
						INSERT IN ARRAY:C227(Arr_Values_4; ($Posindx+1))
						INSERT IN ARRAY:C227(Arr_Values_5; ($Posindx+1))
						INSERT IN ARRAY:C227(Arr_Values_6; ($Posindx+1))
						INSERT IN ARRAY:C227(Arr_Values_7; ($Posindx+1))
						INSERT IN ARRAY:C227(Arr_BreakDown; ($Posindx+1))
						INSERT IN ARRAY:C227(Arr_RevCmts; ($Posindx+1))
						Arr_ItemNos{$Posindx+1}:=Arr_ItemNos{$Posindx}
						Arr_ItemDesc{$Posindx+1}:="     (Original Est.)"
						Arr_Values_1{$Posindx+1}:=arrPtr0_3->{1}{$OrigIndx}
						Arr_Values_2{$Posindx+1}:=arrPtr0_3->{2}{$OrigIndx}
						Arr_Values_3{$Posindx+1}:=arrPtr0_3->{3}{$OrigIndx}
						Arr_Values_4{$Posindx+1}:=arrPtr0_3->{4}{$OrigIndx}
						Arr_Values_5{$Posindx+1}:=arrPtr0_3->{5}{$OrigIndx}
						Arr_Values_6{$Posindx+1}:=arrPtr0_3->{6}{$OrigIndx}
						If ([Work_Estimate:103]Version_L:47>0)
							Arr_Values_7{$Posindx+1}:=arrPtr0_3->{7}{$OrigIndx}
						End if 
						Arr_BreakDown{$Posindx+1}:=Char:C90(0)
						Arr_RevCmts{$Posindx+1}:=Char:C90(0)
						
					End if 
					
				End if 
				
			End if 
		End for 
		wkhr_PgTotal0_1:=arrPtr0_4->{1}
		wkhr_PgTotal0_2:=arrPtr0_4->{2}
		wkhr_PgTotal0_3:=arrPtr0_4->{3}
		wkhr_PgTotal0_4:=arrPtr0_4->{4}
		wkhr_PgTotal0_5:=arrPtr0_4->{5}
		wkhr_PgTotal0_6:=arrPtr0_4->{6}
		If ([Work_Estimate:103]Version_L:47>0)
			wkhr_PgTotal0_7:=arrPtr0_4->{7}
		End if 
		
	Else 
		
	End if 
End if 

C_LONGINT:C283(wkhr_CatAvg_1; wkhr_CatAvg_2; wkhr_CatAvg_3; wkhr_CatAvg_4; wkhr_CatAvg_5; wkhr_CatAvg_6; wkhr_CatAvg_7)
C_LONGINT:C283(wkhr_ItmAvg_1; wkhr_ItmAvg_2; wkhr_ItmAvg_3; wkhr_ItmAvg_4; wkhr_ItmAvg_5; wkhr_ItmAvg_6; wkhr_ItmAvg_7)

READ ONLY:C145([WorkHour_Summary:105])
QUERY:C277([WorkHour_Summary:105]; [WorkHour_Summary:105]ProjType:1=[Contract_Assignment_Maintenance:101]ProjectType:36; *)
QUERY:C277([WorkHour_Summary:105];  & ; [WorkHour_Summary:105]ItemID:2=Num:C11(CategoryPrefix))

If (Records in selection:C76([WorkHour_Summary:105])=1)
	wkhr_CatAvg_1:=[WorkHour_Summary:105]AvgCol1:3
	wkhr_CatAvg_2:=[WorkHour_Summary:105]AvgCol2:4
	wkhr_CatAvg_3:=[WorkHour_Summary:105]AvgCol3:5
	wkhr_CatAvg_4:=[WorkHour_Summary:105]AvgCol4:6
	wkhr_CatAvg_5:=[WorkHour_Summary:105]AvgCol5:7
	wkhr_CatAvg_6:=[WorkHour_Summary:105]AvgSum:8
	wkhr_CatAvg_7:=[WorkHour_Summary:105]AvgCol6:9
	
Else 
	ut_ZeroByPointer("wkhr_CatAvg_$Loop"; 1; 7)
End if 
ut_ZeroByPointer("wkhr_ItmAvg_$Loop"; 1; 7)
