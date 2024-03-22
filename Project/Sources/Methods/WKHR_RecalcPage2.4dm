//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/20/05, 09:55:16
	// ----------------------------------------------------
	// Method: WKHR_RecalcPage2
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(12/28/2005 22:40:42)
	Mods_2005_CM21
	// Modified by: costasmanousakis-(Designer)-(6/3/08 21:53:29)
	Mods_2008_CM_5403  // ("WKHRS")
	// Modified by: costasmanousakis-(Designer)-(2/9/09 22:10:16)
	Mods_2009_CM_5404  //Copied to Server on : 03/19/09, 12:03:35  ` ("WKHRMODS")
End if 
C_BOOLEAN:C305($1; $RecalcTotals)

C_POINTER:C301(arrPtr_3; arrPtr_4; $CatTotCost_ptr)
C_LONGINT:C283($i; $j; $col; $NumItems; $NumReviews; $ItemNum; $RevIndx; $OffEstIndx; $NumOffEst)
ARRAY REAL:C219($Arr_RevTotals; (WKHR_CategoryCount_i+1))
ARRAY REAL:C219($Arr_OffEstTotals; (WKHR_CategoryCount_i+1))
$NumReviews:=0
$NumOffEst:=0
If (Count parameters:C259=1)
	$RecalcTotals:=$1
Else 
	$RecalcTotals:=True:C214
End if 

arrPtr_1:=Get pointer:C304("Arr_"+CategoryPrefix+"_1")  //numbers
arrPtr_3:=Get pointer:C304("Arr_"+CategoryPrefix+"_Values")
arrPtr_4:=Get pointer:C304("Arr_"+CategoryPrefix+"_Totals")
For ($i; 1; (WKHR_CategoryCount_i+1))
	arrPtr_4->{$i}:=0
	$Arr_RevTotals{$i}:=0
	$Arr_OffEstTotals{$i}:=0
End for 

//Sum total hours
$NumItems:=Size of array:C274(arrPtr_3->{1})
For ($j; 1; (WKHR_CategoryCount_i+1))
	For ($i; 1; $NumItems)
		arrPtr_4->{$j}:=arrPtr_4->{$j}+arrPtr_3->{$j}{$i}
		$ItemNum:=Num:C11(arrPtr_1->{$i})
		$RevIndx:=Find in array:C230(Arr_WKHR_ReviewRef; $ItemNum)
		If ($RevIndx>0)
			$Arr_RevTotals{$j}:=$Arr_RevTotals{$j}+arr_WKHR_ReviewVal{$j}{$RevIndx}
			If ($j=6)
				$NumReviews:=$NumReviews+1
			End if 
		Else 
			$Arr_RevTotals{$j}:=$Arr_RevTotals{$j}+arrPtr_3->{$j}{$i}
		End if 
		$OffEstIndx:=Find in array:C230(Arr_WKHR_OfficeEstRef; $ItemNum)
		If ($OffEstIndx>0)
			$Arr_OffEstTotals{$j}:=$Arr_OffEstTotals{$j}+arr_WKHR_OfficeEstVal{$j}{$OffEstIndx}
			If ($j=6)
				$NumOffEst:=$NumOffEst+1
			End if 
		Else 
		End if 
		
	End for 
End for 

//Calculate cost for this category
$CatTotCost_ptr:=Get pointer:C304("Item_"+CategoryPrefix+"_totCost")
$CatTotCost_ptr->:=0
For ($col; 1; WKHR_CategoryCount_i)
	
	If (CategoryPrefix#"900")
		$CatTotCost_ptr->:=$CatTotCost_ptr->+(PayRates{$col}*(arrPtr_4->{WKHR_CatIndx_aL{$col}}))
	Else 
		$CatTotCost_ptr->:=$CatTotCost_ptr->+(ConstrPayRates{$col}*(arrPtr_4->{WKHR_CatIndx_aL{$col}}))
	End if 
End for 
If ($RecalcTotals)
	WKHR_CalcTotals
End if 
$RevIndx:=Find in array:C230(Arr_WKHR_ReviewRef; Num:C11(CategoryPrefix))
If ($NumReviews>0)
	If ($RevIndx>0)
		arr_WKHR_ReviewVal{1}{$RevIndx}:=$Arr_RevTotals{1}
		arr_WKHR_ReviewVal{2}{$RevIndx}:=$Arr_RevTotals{2}
		arr_WKHR_ReviewVal{3}{$RevIndx}:=$Arr_RevTotals{3}
		arr_WKHR_ReviewVal{4}{$RevIndx}:=$Arr_RevTotals{4}
		arr_WKHR_ReviewVal{5}{$RevIndx}:=$Arr_RevTotals{5}
		arr_WKHR_ReviewVal{6}{$RevIndx}:=$Arr_RevTotals{6}
		If ([Work_Estimate:103]Version_L:47>0)
			arr_WKHR_ReviewVal{7}{$RevIndx}:=$Arr_RevTotals{7}
		Else 
			arr_WKHR_ReviewVal{7}{$RevIndx}:=0
		End if 
	Else 
		INSERT IN ARRAY:C227(Arr_WKHR_ReviewRef; 1; 1)
		INSERT IN ARRAY:C227(arr_WKHR_ReviewVal{1}; 1; 1)
		INSERT IN ARRAY:C227(arr_WKHR_ReviewVal{2}; 1; 1)
		INSERT IN ARRAY:C227(arr_WKHR_ReviewVal{3}; 1; 1)
		INSERT IN ARRAY:C227(arr_WKHR_ReviewVal{4}; 1; 1)
		INSERT IN ARRAY:C227(arr_WKHR_ReviewVal{5}; 1; 1)
		INSERT IN ARRAY:C227(arr_WKHR_ReviewVal{6}; 1; 1)
		INSERT IN ARRAY:C227(arr_WKHR_ReviewVal{7}; 1; 1)
		Arr_WKHR_ReviewRef{1}:=Num:C11(CategoryPrefix)
		arr_WKHR_ReviewVal{1}{1}:=$Arr_RevTotals{1}
		arr_WKHR_ReviewVal{2}{1}:=$Arr_RevTotals{2}
		arr_WKHR_ReviewVal{3}{1}:=$Arr_RevTotals{3}
		arr_WKHR_ReviewVal{4}{1}:=$Arr_RevTotals{4}
		arr_WKHR_ReviewVal{5}{1}:=$Arr_RevTotals{5}
		arr_WKHR_ReviewVal{6}{1}:=$Arr_RevTotals{6}
		If ([Work_Estimate:103]Version_L:47>0)
			arr_WKHR_ReviewVal{7}{1}:=$Arr_RevTotals{7}
		Else 
			arr_WKHR_ReviewVal{7}{1}:=0
		End if 
	End if 
	
Else 
	//Clear reviews if any
	If ($RevIndx>0)
		DELETE FROM ARRAY:C228(Arr_WKHR_ReviewRef; $RevIndx; 1)
		DELETE FROM ARRAY:C228(arr_WKHR_ReviewVal{1}; $RevIndx; 1)
		DELETE FROM ARRAY:C228(arr_WKHR_ReviewVal{2}; $RevIndx; 1)
		DELETE FROM ARRAY:C228(arr_WKHR_ReviewVal{3}; $RevIndx; 1)
		DELETE FROM ARRAY:C228(arr_WKHR_ReviewVal{4}; $RevIndx; 1)
		DELETE FROM ARRAY:C228(arr_WKHR_ReviewVal{5}; $RevIndx; 1)
		DELETE FROM ARRAY:C228(arr_WKHR_ReviewVal{6}; $RevIndx; 1)
		DELETE FROM ARRAY:C228(arr_WKHR_ReviewVal{7}; $RevIndx; 1)
		
	End if 
	
End if 
$OffEstIndx:=Find in array:C230(Arr_WKHR_OfficeEstRef; Num:C11(CategoryPrefix))
If ($NumOffEst>0)
	If ($OffEstIndx>0)
		arr_WKHR_OfficeEstVal{1}{$OffEstIndx}:=$Arr_OffEstTotals{1}
		arr_WKHR_OfficeEstVal{2}{$OffEstIndx}:=$Arr_OffEstTotals{2}
		arr_WKHR_OfficeEstVal{3}{$OffEstIndx}:=$Arr_OffEstTotals{3}
		arr_WKHR_OfficeEstVal{4}{$OffEstIndx}:=$Arr_OffEstTotals{4}
		arr_WKHR_OfficeEstVal{5}{$OffEstIndx}:=$Arr_OffEstTotals{5}
		arr_WKHR_OfficeEstVal{6}{$OffEstIndx}:=$Arr_OffEstTotals{6}
		If ([Work_Estimate:103]Version_L:47>0)
			arr_WKHR_OfficeEstVal{7}{$OffEstIndx}:=$Arr_OffEstTotals{7}
		Else 
			arr_WKHR_OfficeEstVal{7}{$OffEstIndx}:=0
		End if 
	Else 
		INSERT IN ARRAY:C227(Arr_WKHR_OfficeEstRef; 1; 1)
		INSERT IN ARRAY:C227(arr_WKHR_OfficeEstVal{1}; 1; 1)
		INSERT IN ARRAY:C227(arr_WKHR_OfficeEstVal{2}; 1; 1)
		INSERT IN ARRAY:C227(arr_WKHR_OfficeEstVal{3}; 1; 1)
		INSERT IN ARRAY:C227(arr_WKHR_OfficeEstVal{4}; 1; 1)
		INSERT IN ARRAY:C227(arr_WKHR_OfficeEstVal{5}; 1; 1)
		INSERT IN ARRAY:C227(arr_WKHR_OfficeEstVal{6}; 1; 1)
		INSERT IN ARRAY:C227(arr_WKHR_OfficeEstVal{7}; 1; 1)
		Arr_WKHR_OfficeEstRef{1}:=Num:C11(CategoryPrefix)
		arr_WKHR_OfficeEstVal{1}{1}:=$Arr_OffEstTotals{1}
		arr_WKHR_OfficeEstVal{2}{1}:=$Arr_OffEstTotals{2}
		arr_WKHR_OfficeEstVal{3}{1}:=$Arr_OffEstTotals{3}
		arr_WKHR_OfficeEstVal{4}{1}:=$Arr_OffEstTotals{4}
		arr_WKHR_OfficeEstVal{5}{1}:=$Arr_OffEstTotals{5}
		arr_WKHR_OfficeEstVal{6}{1}:=$Arr_OffEstTotals{6}
		If ([Work_Estimate:103]Version_L:47>0)
			arr_WKHR_OfficeEstVal{7}{1}:=$Arr_OffEstTotals{7}
		Else 
			arr_WKHR_OfficeEstVal{7}{1}:=0
		End if 
	End if 
Else 
	//Clear estimate if any
	If ($OffEstIndx>0)
		DELETE FROM ARRAY:C228(Arr_WKHR_OfficeEstRef; $RevIndx; 1)
		DELETE FROM ARRAY:C228(arr_WKHR_OfficeEstVal{1}; $RevIndx; 1)
		DELETE FROM ARRAY:C228(arr_WKHR_OfficeEstVal{2}; $RevIndx; 1)
		DELETE FROM ARRAY:C228(arr_WKHR_OfficeEstVal{3}; $RevIndx; 1)
		DELETE FROM ARRAY:C228(arr_WKHR_OfficeEstVal{4}; $RevIndx; 1)
		DELETE FROM ARRAY:C228(arr_WKHR_OfficeEstVal{5}; $RevIndx; 1)
		DELETE FROM ARRAY:C228(arr_WKHR_OfficeEstVal{6}; $RevIndx; 1)
		DELETE FROM ARRAY:C228(arr_WKHR_OfficeEstVal{7}; $RevIndx; 1)
		
	End if 
	
End if 